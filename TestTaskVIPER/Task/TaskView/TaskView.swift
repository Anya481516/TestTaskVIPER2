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

  lazy var titleTextView: UITextView = {
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

  lazy var descriptionTextField: UITextView = {
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
    addSubview(titleTextView)
    titleTextView.text = task.title
    addSubview(dateLabel)
    dateLabel.text = task.date.getFormattedDate(format: "dd/MM/yyy")
    addSubview(descriptionTextField)
    descriptionTextField.text = task.taskDescription
    setupLayout()
  }

  func setupLayout() {
    NSLayoutConstraint.activate([
      titleTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      titleTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),

      dateLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 8),
      dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      descriptionTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
      descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      descriptionTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
    ])
  }
}

extension TaskView: UITextViewDelegate {
  func textFieldTextDidChange(textField: UITextField) {
    textField.invalidateIntrinsicContentSize()
  }
}
