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
  func save() {
    
  }
  

  weak var presenter: TaskInteractorOutput?
  lazy var coreDataManager = CoreDataManager.shared

  func viewWIllDisappear(with task: TodoTask) {
    guard !task.title.isEmpty || !task.taskDescription.isEmpty else {
      coreDataManager.delete(task)
      return
    }
    coreDataManager.saveContext()
  }
}
