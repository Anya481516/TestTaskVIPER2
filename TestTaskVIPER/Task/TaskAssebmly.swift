//
//  TaskAssebmly.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import UIKit

class TaskAssembly {
  static func buildTaskModule(
    task: TodoTask,
    type: TaskView.ViewType
  ) -> UIViewController {
    let view = TaskViewController(task: task, type: type)
    let interactor = TaskInteractor()
    let presenter = TaskPresenter()
    //let router = TaskRouter()

    view.presenter = presenter

    presenter.view = view
    presenter.interactor = interactor
    //presenter.router = router

    interactor.presenter = presenter

    //router.view = view

    return view
  }

  private init() {}
}

