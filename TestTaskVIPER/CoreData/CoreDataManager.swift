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

  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  // MARK: - Core Data stack

  private(set) lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TestTaskVIPER")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  func saveContext(completion:  ((Error?) -> Void)? = nil) {
    let context = viewContext
    DispatchQueue.global(qos: .default).async {
      guard context.hasChanges else { return }
      do {
        try context.save()
        DispatchQueue.main.async {
          completion?(nil)
        }
      } catch {
        DispatchQueue.main.async {
          completion?(error)
        }
      }
    }
  }

  func obtainData(completion: @escaping ([TodoTask]) -> Void) {
    let context = viewContext
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

  func delete(_ task: TodoTask) throws {
    let context = viewContext
    DispatchQueue.global(qos: .default).async { [weak self] in
      guard let self else { return }
      context.delete(task)
      self.saveContext()
    }
  }

  func delete(_ task: TodoTask, completion:  ((Error?) -> Void)? = nil) {
    let context = viewContext
    DispatchQueue.global(qos: .default).async { [weak self] in
      guard let self else { return }
      context.delete(task)
      self.saveContext(completion: completion)
    }
  }

  func addNewTask(completion: @escaping (Result<TodoTask, Error>) -> Void) {
    let context = viewContext
    let task = TodoTask(context: context)
    DispatchQueue.global(qos: .default).async {
      guard context.hasChanges else { return }
      do {
        try context.save()
        DispatchQueue.main.async {
          completion(.success(task))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
}
