//
//  TodoTask+CoreDataClass.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 22.11.2024.
//
//

import Foundation
import CoreData

@objc(TodoTask)
public class TodoTask: NSManagedObject {

  convenience init(context: NSManagedObjectContext) {
    let entity = NSEntityDescription.entity(forEntityName: "TodoTask", in: context)!
    self.init(entity: entity, insertInto: context)

    id = UUID().uuidString
    title = ""
    taskDescription = ""
    isCompleted = false
    date = Date()
  }

  convenience init(
    context: NSManagedObjectContext,
    id: String = UUID().uuidString,
    title: String = "",
    taskDescription: String = "",
    isCompleted: Bool = false,
    date: Date = Date()
  ) {
    let entity = NSEntityDescription.entity(forEntityName: "TodoTask", in: context)!
    self.init(entity: entity, insertInto: context)

    self.id = id
    self.title = title
    self.taskDescription = taskDescription
    self.isCompleted = isCompleted
    self.date = date
  }

}
