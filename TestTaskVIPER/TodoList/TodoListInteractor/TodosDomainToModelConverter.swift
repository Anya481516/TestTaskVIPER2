//
//  TodosDomainToModelConverter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

struct TodosDomainToModelConverter {
  func convert(_ domain: Todos?) -> [TaskItem] {
    guard let todos = domain?.todos else { return [] }

    return todos.map { convert(domainTodo: $0) }
  }

  func convert(domainTodo: Todos.Todo) -> TaskItem {
    TaskItem(
      id: String(domainTodo.id),
      title: domainTodo.todo,
      description: domainTodo.todo, // nil
      isCompleted: domainTodo.isCompleted,
      date: "10/12/2024" // nil
    )
  }
}
