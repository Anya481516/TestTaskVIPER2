//
//  Untitled.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TodoListViewController: UIViewController, TodoListPresenterOutput {

  enum TableSection {
    case main
  }

  var presenter: TodoListPresenterInput!

  private var todoListView = TodoListView()

  private lazy var tableView: UITableView = {
    var tableView = todoListView.tableView
    tableView.delegate = self
    return tableView
  }()

  private lazy var searchBar: UISearchBar = {
    var searchBar = todoListView.searchBar
    return searchBar
  }()

  private lazy var toolBarTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 11)
    label.textAlignment = NSTextAlignment.center
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()

  var dataSource: UITableViewDiffableDataSource<TableSection, TodoTask>?

  override func loadView() {
    super.loadView()
    view = todoListView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupDataSource()
    setupToolBar()

    searchBar.delegate = self

    presenter.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    presenter.viewWillAppear()
    self.navigationController?.isToolbarHidden = false

  }

  func updateUI(with tasks: [TodoTask], animated: Bool) {
    updateDataSource(with: tasks, animate: animated)
  }

  func setupToolBar() {
    var items = [UIBarButtonItem]()

    let barLabel = UIBarButtonItem(customView: toolBarTitleLabel)

    let rightButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(add))

    let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    leftSpacer.width = rightButton.customView?.frame.width ?? 44

    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    items = [leftSpacer, spacer, barLabel, spacer, rightButton]
    self.toolbarItems = items

    self.navigationController?.toolbar.backgroundColor = .darkGray
    self.navigationController?.toolbar.tintColor = ColorScheme.cutsomYellow
  }

  func setupDataSource() {
    tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
    tableView.dataSource = self
//    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
//      let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as! TodoListTableViewCell
//      cell.configureCell(with: task)
//      return cell
//    })
  }

  func updateDataSource(with tasks: [TodoTask], animate: Bool) {
//    var snapshot = NSDiffableDataSourceSnapshot<TableSection, TodoTask>()
//    snapshot.appendSections([.main])
//    snapshot.appendItems(tasks)
//    dataSource?.apply(snapshot, animatingDifferences: animate)
    tableView.reloadData()
    toolBarTitleLabel.text = presenter.getToolBarLabelText(for: tasks.count)
  }

  @objc func add(_ sender: UIBarButtonItem) {
    presenter.didTapNewTask()
  }

}

extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.getTasksCount()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as! TodoListTableViewCell
    let task = presenter.getTask(indexPath.row)
    cell.configureCell(with: task)
    return cell
  }
}

extension TodoListViewController: UITableViewDelegate {
  func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
  ) {
    let row = indexPath.row
    tableView.deselectRow(at: indexPath, animated: false)
    presenter.didTapTaskAt(row)
  }

  func tableView(
      _ tableView: UITableView,
      contextMenuConfigurationForRowAt indexPath: IndexPath,
      point: CGPoint
  ) -> UIContextMenuConfiguration? {

    let index = indexPath.row
    let identifier = "\(index)" as NSString

    let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { [weak self] _ in
      self?.presenter.didTapEditTaskAt(indexPath.row)
    }
    let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
      self?.presenter.didTapShareTaskAt(indexPath.row)
    }
    let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash")) { [weak self] _ in
      self?.presenter.didTapDeleteTaskAt(indexPath.row)
    }
    let actionProvider: UIContextMenuActionProvider = { _ in
      return UIMenu(children: [editAction, shareAction, deleteAction])
    }

    let task = presenter.getTask(indexPath.row)
    let previewProvider = TodoPreviewViewController(task: task)
    //previewProvider!.preferredContentSize = CGSize(width: previewProvider!.view.frame.width, height: previewProvider!.view.frame.height)

//    let previewParams = UIPreviewParameters()
//    previewParams.backgroundColor = .clear
//
//    var targetedPreview: UITargetedPreview
//
//    if let task = presenter.getTask(indexPath.row) {
//      let preview = TodoPreviewView(task: task)
//      previewParams.visiblePath = UIBezierPath(roundedRect: preview.bounds, cornerRadius: 10)
//      let target = UIPreviewTarget(container: preview.superview!, center: preview.center)
//      targetedPreview = UITargetedPreview(view: preview, parameters: previewParams, target: target)
//    }

    //let provider: UIContextMenuContentPreviewProvider

    return UIContextMenuConfiguration(
      identifier: identifier,
      previewProvider: { previewProvider },
      actionProvider: actionProvider
    )
  }

//  func tableView(_ tableView: UITableView,
//    previewForHighlightingContextMenuWithConfiguration
//    configuration: UIContextMenuConfiguration
//  ) -> UITargetedPreview? {
//    guard
//      let identifier = configuration.identifier as? String,
//      let index = Int(identifier),
//      let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TodoListTableViewCell
//      else {
//        return nil
//    }
//
//    return UITargetedPreview(view: cell.mainStackView)
//  }
}

extension TodoListViewController: UISearchBarDelegate {

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     presenter.didSearchWith(searchText)
   }

   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     searchBar.text = ""
     presenter.didFinishSearch()
   }
 }
