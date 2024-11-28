//
//  TodosDomainToModelConverter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

class TodosDomainToModelConverter {
  
  private lazy var dataManager = CoreDataManager.shared

  func convert(_ domain: Todos?) -> [TodoTask] {
    guard let todos = domain?.todos else { return [] }
    
    return todos.map { convert(domainTodo: $0) }
  }
  
  private func convert(domainTodo: Todos.Todo) -> TodoTask {
    let task = TodoTask(context: dataManager.viewContext)
    task.id = String(domainTodo.id)
    task.title = domainTodo.todo
    task.taskDescription = ""
    task.isCompleted = domainTodo.isCompleted
    task.date = Date()
    
    return task
  }
}
