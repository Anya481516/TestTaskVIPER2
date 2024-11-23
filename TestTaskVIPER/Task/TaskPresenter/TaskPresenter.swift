//
//  TaskPresenter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskPresenterInput: AnyObject {
  func viewWIllDisappear(with task: TodoTask)
}

protocol TaskPresenterOutput: AnyObject {

}

class TaskPresenter: TaskPresenterInput, TaskInteractorOutput {

  weak var view: TaskPresenterOutput?
  var interactor: TaskInteractorInput?
  //var router: TaskRouterInput?

  func viewWIllDisappear(with task: TodoTask) {
    interactor?.viewWIllDisappear(with: task)
  }
}
