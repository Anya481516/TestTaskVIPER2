//
//  Untitled.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TaskViewController: UIViewController, TaskPresenterOutput {

  private var taskView: TaskView

  var presenter: TaskPresenterInput?

  init(
    task: TodoTask,
    type: TaskView.ViewType
  ) {
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

    self.navigationController?.isToolbarHidden = true
    self.navigationController?.navigationBar.tintColor = ColorScheme.cutsomYellow
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // TODO: save data
  }
}
