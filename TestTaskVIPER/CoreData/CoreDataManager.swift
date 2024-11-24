//
//  CoreDataManager.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 22.11.2024.
//

import Foundation
import CoreData

class CoreDataManager {

  static let shared = CoreDataManager()

  private init() {}

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TestTaskVIPER")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func obtainData() -> [TodoTask] {
    let taskFetchRequest = TodoTask.fetchRequest()
    let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    taskFetchRequest.sortDescriptors = [dateSortDescriptor, idSortDescriptor]

    let context = persistentContainer.viewContext
    let result = try? context.fetch(taskFetchRequest)

    return result ?? []
  }

  func delete(_ task: TodoTask) {
    let context = persistentContainer.viewContext

    context.delete(task)
    saveContext()
  }
}
