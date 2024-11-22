//
//  TaskInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskInteractorInput: AnyObject {
  func save(task: TaskItem)
}

protocol TaskInteractorOutput: AnyObject {

}

class TaskInteractor: TaskInteractorInput {

  weak var presenter: TaskInteractorOutput?

  func save(task: TaskItem) {
    // TODO: saving
    //presemter.
  }
}
