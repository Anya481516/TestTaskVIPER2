//
//  TodoPreviewView.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 24.11.2024.
//

import UIKit

class TodoPreviewViewController: UIViewController {
  
  private lazy var mainStackView: MainStackView = {
    let view = MainStackView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let task: TodoTask

  init(
    task: TodoTask
  ) {
    self.task = task
    super.init(nibName: nil, bundle: nil)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    view.addSubview(mainStackView)
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    ])
    
    mainStackView.configure(with: task)
  }
  
  func getContentSize() -> CGSize {
    let width = view.bounds.width - 32
    let height = mainStackView.getContentHeight(width: width) + 32
    return CGSize(width: width, height: height)
  }
}
