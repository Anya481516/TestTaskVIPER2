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

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 12)
    return label
  }()

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray
    return label
  }()

  var mainStackView = UIStackView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupLayout()
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    statusImageView.image = nil
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupLayout() {

    guard statusImageView.superview == nil else { return }

    mainStackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel, dateLabel])
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.axis = .vertical
    mainStackView.distribution = .fillEqually
    mainStackView.spacing = 6

    //contentView.addSubview(titleLabel)
    contentView.addSubview(statusImageView)
    contentView.addSubview(mainStackView)

    NSLayoutConstraint.activate([
      statusImageView.widthAnchor.constraint(equalToConstant: 24),
      statusImageView.heightAnchor.constraint(equalToConstant: 24),
      statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

//      titleLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 4),
//      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//      titleLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),

      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
      mainStackView.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 4),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
    ])
  }

  func configureCell(with task: TodoTask) {
    titleLabel.text = task.title
    descriptionLabel.text = task.taskDescription
    dateLabel.text = task.date.getFormattedDate(format: "dd/MM/yyyy")

    if task.isCompleted {
      configureCompletedAppearance()
    } else {
      configureUncompletedAppearance()
    }
  }

  private func configureCompletedAppearance() {
    statusImageView.image = UIImage(systemName: "checkmark.circle")
    statusImageView.tintColor = ColorScheme.cutsomYellow
    titleLabel.textColor = .systemGray
    descriptionLabel.textColor = .systemGray
    //titleLabel.strikeThrough(true)
  }

  private func configureUncompletedAppearance() {
    statusImageView.image = UIImage(systemName: "circle")
    statusImageView.tintColor = ColorScheme.customGray
    titleLabel.textColor = .white
    descriptionLabel.textColor = .white
    //titleLabel.strikeThrough(false)
  }

}

extension TodoListTableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
