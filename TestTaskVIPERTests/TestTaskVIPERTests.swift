//
//  TestTaskVIPERTests.swift
//  TestTaskVIPERTests
//
//  Created by Nikita Komarov on 28.11.2024.
//

import XCTest
import CoreData
@testable import TestTaskVIPER


public final class TestTaskVIPERTests: XCTestCase {

  private lazy var coreDataManager = CoreDataManager.shared

  func testAddNewTask() throws {
    // Given
    let expectation = self.expectation(description: "add task expectation")
    var result: Result<TodoTask, Error>?

    // When
    addNewTask { taskResult in
      result = taskResult
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)

    // Then
    switch result {
    case .success(let task):
      XCTAssertNotNil(task, "The task should not be nil")
      XCTAssertNotNil(task.id, "The task's id should not be nil")

      let fetchRequest: NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
      let tasks = try coreDataManager.viewContext.fetch(fetchRequest)
      XCTAssertEqual(tasks.count, 1, "There should be exactly one task in the database")
      XCTAssertEqual(tasks.first, task, "The saved task should match the returned task")

    case .failure(let error):
      XCTFail("Expected success, but got failure with error: \(error)")

    case .none:
      XCTFail("Expected a result, but got none")
    }
  }


  func addNewTask(completion: @escaping (Result<TodoTask, Error>) -> Void) {
    let context = coreDataManager.viewContext
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

  func testDeleteTask() throws {
    // Given
    let viewContext = coreDataManager.viewContext
    let expectation = self.expectation(description: "delete task expectation")
    var completionError: Error?

    // Create a task to delete
    let task = TodoTask(context: viewContext)
    task.date = Date()
    try viewContext.save()

    // Verify the task exists
    let fetchRequest: NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
    let tasksBeforeDelete = try viewContext.fetch(fetchRequest)
    XCTAssertEqual(tasksBeforeDelete.count, 1, "There should be one task before deletion")

    // When
    delete(task) { error in
      completionError = error
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)

    // Then
    XCTAssertNil(completionError, "Completion handler error should be nil")
    let tasksAfterDelete = try viewContext.fetch(fetchRequest)
    XCTAssertEqual(tasksAfterDelete.count, 0, "There should be no tasks after deletion")
  }

  func delete(_ task: TodoTask, completion: ((Error?) -> Void)? = nil) {
    let context = coreDataManager.viewContext
    DispatchQueue.global(qos: .default).async {
      context.delete(task)
      if context.hasChanges {
        do {
          try context.save()
          completion?(nil)
        } catch {
          completion?(error)
        }
      }
    }
  }

}
