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
      //mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
      //mainStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, constant: 32),
    ])
    
    mainStackView.configure(with: task)

    preferredContentSize = CGSize(width: view.bounds.width, height: mainStackView.bounds.height)
  }
}

//class TodoPreviewView: UIView {
//
//  private lazy var mainStackView: MainStackView = {
//    let view = MainStackView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()
//
//  private let task: TodoTask
//
//  init(
//    task: TodoTask
//  ) {
//    self.task = task
//    super.init(frame: .zero)
//    setupUI()
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  private func setupUI() {
//    addSubview(mainStackView)
//
//    NSLayoutConstraint.activate([
//      mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//    ])
//
//    mainStackView.configure(with: task)
//  }
//}
//
