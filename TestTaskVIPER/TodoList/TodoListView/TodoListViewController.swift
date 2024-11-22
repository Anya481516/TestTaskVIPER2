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

  var presenter: TodoListPresenterInput?

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

    presenter?.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.isToolbarHidden = false

  }

  func updateUI(with tasks: [TodoTask], animated: Bool) {
    updateDataSource(with: tasks, animate: animated)
  }

  func setupToolBar() {
    var items = [UIBarButtonItem]()

    let label = UILabel()
    label.text = "7 Задач"
    label.font = UIFont.boldSystemFont(ofSize: 11)
    label.textAlignment = NSTextAlignment.center
    let barLabel = UIBarButtonItem(customView: label)

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
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
      let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as! TodoListTableViewCell
      cell.configureCell(with: task)
      return cell
    })
  }

  func updateDataSource(with tasks: [TodoTask], animate: Bool) {
    var snapshot = NSDiffableDataSourceSnapshot<TableSection, TodoTask>()
    snapshot.appendSections([.main])
    snapshot.appendItems(tasks)
    dataSource?.apply(snapshot, animatingDifferences: animate)
  }

  @objc func add(_ sender: UIBarButtonItem) {
    presenter?.didTapNewTask()
  }
}

extension TodoListViewController: UITableViewDelegate {
  func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
  ) {
    let row = indexPath.row
    tableView.deselectRow(at: indexPath, animated: false)
    presenter?.didTapTaskAt(row)
  }

  func tableView(
      _ tableView: UITableView,
      contextMenuConfigurationForRowAt indexPath: IndexPath,
      point: CGPoint
  ) -> UIContextMenuConfiguration? {

    let index = indexPath.row
    let identifier = "\(index)" as NSString

    let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { [weak self] _ in
      self?.presenter?.didTapEditTaskAt(indexPath.row)
    }
    let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
      self?.presenter?.didTapShareTaskAt(indexPath.row)
    }
    let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash")) { [weak self] _ in
      self?.presenter?.didTapDeleteTaskAt(indexPath.row)
    }
    let actionProvider: UIContextMenuActionProvider = { _ in
      return UIMenu(children: [editAction, shareAction, deleteAction])
    }

    return UIContextMenuConfiguration(
      identifier: identifier,
      previewProvider: nil,
      actionProvider: actionProvider
    )


//    return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { action in
//      let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { [weak self] _ in
//        self?.presenter?.didTapEditTaskAt(indexPath.row)
//      }
//
//      let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { [weak self] _ in
//        self?.presenter?.didTapShareTaskAt(indexPath.row)
//      }
//
//      let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash")) { [weak self] _ in
//        self?.presenter?.didTapDeleteTaskAt(indexPath.row)
//      }
//
////      let actionProvider: UIContextMenuActionProvider = { _ in
////        return UIMenu(children: [editAction, shareAction, deleteAction])
////      }
////
////      return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
////        return CustomPreviewViewController(item: selectedItem)
////      }, actionProvider: actionProvider)
//
////      let index = indexPath.row
////      let identifier = "\(index)" as NSString
////
////      return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil, actionProvider: actionProvider)
//
//      return UIMenu(children: [editAction, shareAction, deleteAction])
//    }
  }

  func tableView(_ tableView: UITableView,
    previewForHighlightingContextMenuWithConfiguration
    configuration: UIContextMenuConfiguration
  ) -> UITargetedPreview? {
    guard
      let identifier = configuration.identifier as? String,
      let index = Int(identifier),
      let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TodoListTableViewCell
      else {
        return nil
    }

    return UITargetedPreview(view: cell.mainStackView)
  }
}

extension TodoListViewController: UISearchBarDelegate {

   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     presenter?.didSearchWith(searchText)
   }

   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     searchBar.text = ""
     presenter?.didFinishSearch()
   }
 }
