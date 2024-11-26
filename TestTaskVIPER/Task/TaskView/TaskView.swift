//
//  TaskView.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import UIKit

class TaskView: UIView {

  enum ViewType {
    case new
    case existing
  }

  private lazy var scrollView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.translatesAutoresizingMaskIntoConstraints = false
    return scroll
  }()

  private lazy var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private(set) lazy var titleTextView: UITextView = {
    let text = UITextView()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.font = UIFont.boldSystemFont(ofSize: 34)
    text.delegate = self
    text.isScrollEnabled = false
    return text
  }()

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    return label
  }()

  private(set) lazy var descriptionTextView: UITextView = {
    let text = UITextView()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.font = UIFont.systemFont(ofSize: 16)
    text.delegate = self
    text.isScrollEnabled = false
    return text
  }()

  private var task: TodoTask

  init(
    task: TodoTask,
    type: ViewType
  ) {

    self.task = task
    super.init(frame: .zero)
    setupUI()
    if type == .new { titleTextView.becomeFirstResponder() }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)

    contentView.addSubview(titleTextView)
    contentView.addSubview(dateLabel)
    contentView.addSubview(descriptionTextView)

    titleTextView.text = task.title
    dateLabel.text = task.date.getFormattedDate(format: "dd/MM/yyy")
    descriptionTextView.text = task.taskDescription

    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      titleTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      titleTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      titleTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),

      dateLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 8),
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
      descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}

extension TaskView: UITextViewDelegate {
  func textFieldTextDidChange(textField: UITextField) {
    textField.invalidateIntrinsicContentSize()
  }
}
