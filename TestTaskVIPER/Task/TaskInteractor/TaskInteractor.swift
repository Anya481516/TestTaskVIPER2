//
//  TaskInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 21.11.2024.
//

import Foundation

protocol TaskInteractorInput: AnyObject {
  func saveTask(_ task: TodoTask)
}

class TaskInteractor: TaskInteractorInput {

  private lazy var coreDataManager = CoreDataManager.shared

  func saveTask(_ task: TodoTask) {
    do {
      guard !task.title.isEmpty || !task.taskDescription.isEmpty else {
        try coreDataManager.delete(task)
        return
      }
      coreDataManager.saveContext() { error in
        if let error {
          print("Failed to save tasks: \(error)")
        }
      }
    } catch {
      print("Failed deleting task: \(error)")
    }
  }
}
