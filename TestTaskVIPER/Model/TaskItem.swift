//
//  TaskItem.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

struct TaskItem: Hashable {
  private let id: String
  let title: String
  let description: String
  var isCompleted: Bool
  let date: String?

//  mutating func changeStatus() {
//    isCompleted.toggle()
//  }

  internal init(
    id: String = UUID().uuidString,
    title: String = "",
    description: String = "",
    isCompleted: Bool = false,
    date: String? = Date().getFormattedDate(format: "dd/MM/yyy")
  ) {
    self.id = id
    self.title = title
    self.description = description
    self.isCompleted = isCompleted
    self.date = date
  }
}
