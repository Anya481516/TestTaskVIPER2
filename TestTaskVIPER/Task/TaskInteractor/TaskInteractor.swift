//
//  TaskInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskInteractorInput: AnyObject {
  func save(task: TodoTask)
}

protocol TaskInteractorOutput: AnyObject {

}

class TaskInteractor: TaskInteractorInput {

  weak var presenter: TaskInteractorOutput?
  lazy var dataManager = CoreDataManager.shared

  func save(task: TodoTask) {
    // TODO: saving
    //presemter.
  }
}
