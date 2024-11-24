//
//  TodoTableViewCell.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

  private lazy var statusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private var mainStackView = MainStackView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupLayout()
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    statusImageView.image = nil
    mainStackView.prepareForReuse()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {

    guard statusImageView.superview == nil else { return }
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(statusImageView)
    contentView.addSubview(mainStackView)

    NSLayoutConstraint.activate([
      statusImageView.widthAnchor.constraint(equalToConstant: 24),
      statusImageView.heightAnchor.constraint(equalToConstant: 24),
      statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
      mainStackView.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 4),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
    ])
  }

  func configureCell(with task: TodoTask) {
    mainStackView.configure(with: task)

    if task.isCompleted {
      configureCompletedAppearance()
    } else {
      configureUncompletedAppearance()
    }
  }

  private func configureCompletedAppearance() {
    statusImageView.image = UIImage(systemName: "checkmark.circle")
    statusImageView.tintColor = ColorScheme.cutsomYellow
    mainStackView.changeStatusToCompleted()
  }

  private func configureUncompletedAppearance() {
    statusImageView.image = UIImage(systemName: "circle")
    statusImageView.tintColor = ColorScheme.customGray
    mainStackView.changeStatusToUncompleted()
  }

}

extension TodoListTableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
