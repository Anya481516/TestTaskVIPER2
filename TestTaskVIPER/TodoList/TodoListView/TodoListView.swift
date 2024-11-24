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
    bar.placeholder = "Search"
    bar.sizeToFit()
    return bar
  }()
  
  lazy var tableView: UITableView = {
    var table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
    table.estimatedRowHeight = 120
    table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
    tableView.tableHeaderView = searchBar
  }
  
  private func setupTableView() {
    addSubview(tableView)
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
