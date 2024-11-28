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
    
    view.presenter = presenter

    presenter.interactor = interactor
    
    return view
  }
  
  private init() {}
}
