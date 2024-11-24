//
//  MainStackView.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 24.11.2024.
//

import UIKit

class MainStackView: UIStackView {
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
  
  private var titleText = ""
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addArrangedSubview(titleLabel)
    addArrangedSubview(descriptionLabel)
    addArrangedSubview(dateLabel)
    
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    distribution = .fillEqually
    spacing = 6
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with task: TodoTask) {
    titleText = task.title
    titleLabel.text = titleText
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
  
  func getContentHeight() -> CGFloat {
    return titleLabel.bounds.height + descriptionLabel.bounds.height + dateLabel.bounds.height + 12
  }
}
