//
//  TaskPresenter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskPresenterInput: AnyObject {
  func viewWillDisappear(with task: TodoTask)
}

class TaskPresenter: TaskPresenterInput {

  var interactor: TaskInteractorInput?

  func viewWillDisappear(with task: TodoTask) {
    interactor?.saveTask(task)
  }
}
