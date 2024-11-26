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
}

class MainStackView: UIStackView {
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = Constants.titleFont
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    label.font = Constants.descriptionFont
    return label
  }()
  
  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = Constants.dateFont
    label.textColor = .systemGray
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addArrangedSubview(titleLabel)
    addArrangedSubview(descriptionLabel)
    addArrangedSubview(dateLabel)
    
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    distribution = .fillEqually
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

    let titleHeight = titleLabel.text?.height(constraintedWidth: width, font: Constants.titleFont, numberOfLines: 1) ?? 0
    let descriptionHeight = descriptionLabel.text?.height(constraintedWidth: width, font: Constants.descriptionFont, numberOfLines: 2) ?? 0
    let dateHeight = descriptionLabel.text?.height(constraintedWidth: width, font: Constants.dateFont, numberOfLines: 1) ?? 0

    return titleHeight + descriptionHeight + dateHeight + Constants.spacing * 4
  }
}
