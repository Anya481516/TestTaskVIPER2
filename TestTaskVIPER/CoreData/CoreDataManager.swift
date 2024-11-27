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

  private(set) lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TestTaskVIPER")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  func saveContext() {
    let context = persistentContainer.viewContext
    DispatchQueue.global(qos: .default).async {
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          let nserror = error as NSError
          print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
  }


  func obtainData(completion: @escaping ([TodoTask]) -> Void) {
    let context = persistentContainer.viewContext
    DispatchQueue.global(qos: .default).async {
      let taskFetchRequest = TodoTask.fetchRequest()
      let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
      let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
      taskFetchRequest.sortDescriptors = [dateSortDescriptor, idSortDescriptor]

      do {
        let result = try context.fetch(taskFetchRequest)
        DispatchQueue.main.async {
          completion(result)
        }
      } catch {
        print("Failed to fetch TodoTask: \(error)")
        DispatchQueue.main.async {
          completion([])
        }
      }
    }
  }

  func delete(_ task: TodoTask) {
    let context = persistentContainer.viewContext
    DispatchQueue.global(qos: .default).async { [weak self] in
      guard let self else { return }
      context.delete(task)
      self.saveContext()
    }
  }
}
