//
//  TodoListView.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TodoListView: UIView {

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.boldSystemFont(ofSize: 34)
    label.text = "Задачи"
    return label
  }()

  lazy var searchBar: UISearchBar = {
    var bar = UISearchBar()
    bar.translatesAutoresizingMaskIntoConstraints = false
    bar.placeholder = "Search"
    return bar
  }()

  lazy var tableView: UITableView = {
    var table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
    table.estimatedRowHeight = 120
    return table
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    addSubview(titleLabel)
    setupSearchBar()
    setupTableView()
    setupLayout()
  }

  private func setupSearchBar() {
    addSubview(searchBar)
  }

  private func setupTableView() {
    addSubview(tableView)
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
