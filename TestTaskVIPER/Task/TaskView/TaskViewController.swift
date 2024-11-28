//
//  Untitled.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TaskViewController: UIViewController {

  private var taskView: TaskView

  private lazy var titleTextView: UITextView = {
    var textView = taskView.titleTextView
    return textView
  }()

  private lazy var descriptionTextView: UITextView = {
    var textView = taskView.descriptionTextView
    return textView
  }()

  var presenter: TaskPresenterInput!
  var task: TodoTask

  init(
    task: TodoTask,
    type: TaskView.ViewType
  ) {
    self.task = task
    self.taskView = TaskView(task: task, type: type)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view = taskView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    titleTextView.delegate = self
    descriptionTextView.delegate = self
    self.navigationController?.isToolbarHidden = true
    self.navigationController?.navigationBar.tintColor = ColorScheme.cutsomYellow
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    presenter.viewWillDisappear(with: task)
  }
}

extension TaskViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if textView == self.titleTextView {
      task.title = textView.text
    } else if textView == self.descriptionTextView {
      task.taskDescription = textView.text
    }
  }
}
