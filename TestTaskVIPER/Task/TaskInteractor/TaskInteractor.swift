//
//  TaskInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskInteractorInput: AnyObject {
  func viewWIllDisappear(with task: TodoTask)
}

protocol TaskInteractorOutput: AnyObject {

}

class TaskInteractor: TaskInteractorInput {

  weak var presenter: TaskInteractorOutput?
  private lazy var coreDataManager = CoreDataManager.shared
  
  func viewWIllDisappear(with task: TodoTask) {
    do {
      guard !task.title.isEmpty || !task.taskDescription.isEmpty else {
        try coreDataManager.delete(task)
        return
      }
      try coreDataManager.saveContext()
    } catch {
      print("Failed to save tasks: \(error)")
      // TODO: handle the error
    }
  }
}
