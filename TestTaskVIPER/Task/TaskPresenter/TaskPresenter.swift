//
//  TaskPresenter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskPresenterInput: AnyObject {
  func didLeaveScreen(task: TaskItem)
}

protocol TaskPresenterOutput: AnyObject {

}

class TaskPresenter: TaskPresenterInput, TaskInteractorOutput {

  weak var view: TaskPresenterOutput?
  var interactor: TaskInteractorInput?
  //var router: TaskRouterInput?

  func didLeaveScreen(task: TaskItem) {
    //interactor.
  }
}
