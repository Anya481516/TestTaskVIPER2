//
//  MainStackView.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 24.11.2024.
//

import UIKit

private enum Constants {
  static let titleFont = UIFont.boldSystemFont(ofSize: 16)
  static let descriptionFont = UIFont.systemFont(ofSize: 12)
  static let dateFont = UIFont.systemFont(ofSize: 12)
  static let spacing: CGFloat = 6
  static let dateLabelNumberOfLines: Int = 1
}

class MainStackView: UIStackView {

  enum StackViewType {
    case cell
    case preview
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Constants.titleFont
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Constants.descriptionFont
    return label
  }()
  
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Constants.dateFont
    label.textColor = .systemGray
    label.numberOfLines = Constants.dateLabelNumberOfLines
    return label
  }()

  private var titleLabelNumberOfLines: Int
  private var descriptionLabelNumberOfLines: Int

  init(type: StackViewType) {
    switch type {
    case .cell:
      titleLabelNumberOfLines = 1
      descriptionLabelNumberOfLines = 2
    case .preview:
      titleLabelNumberOfLines = 0
      descriptionLabelNumberOfLines = 0
    }

    super.init(frame: .zero)

    titleLabel.numberOfLines = titleLabelNumberOfLines
    descriptionLabel.numberOfLines = descriptionLabelNumberOfLines
    dateLabel.numberOfLines = Constants.dateLabelNumberOfLines

    addArrangedSubview(titleLabel)
    addArrangedSubview(descriptionLabel)
    addArrangedSubview(dateLabel)

    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    spacing = Constants.spacing
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with task: TodoTask) {
    titleLabel.text = task.title
    descriptionLabel.text = task.taskDescription
    dateLabel.text = task.date.getFormattedDate(format: "dd/MM/yyyy")
  }
  
  func changeStatusToCompleted() {
    titleLabel.textColor = .systemGray
    descriptionLabel.textColor = .systemGray
    titleLabel.strikeThrough(true)
  }
  
  func changeStatusToUncompleted() {
    titleLabel.textColor = .white
    descriptionLabel.textColor = .white
  }
  
  func prepareForReuse() {
    titleLabel.attributedText = nil
  }
  
  func getContentHeight(width: CGFloat) -> CGFloat {

    let titleHeight = titleLabel.text?.height(constraintedWidth: width, font: Constants.titleFont, numberOfLines: titleLabelNumberOfLines) ?? 0
    let descriptionHeight = descriptionLabel.text?.height(constraintedWidth: width, font: Constants.descriptionFont, numberOfLines: descriptionLabelNumberOfLines) ?? 0
    let dateHeight = descriptionLabel.text?.height(constraintedWidth: width, font: Constants.dateFont, numberOfLines: Constants.dateLabelNumberOfLines) ?? 0

    return titleHeight + descriptionHeight + dateHeight + Constants.spacing * 2
  }
}
