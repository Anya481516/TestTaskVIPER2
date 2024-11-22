//
//  TodoListInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

protocol TodoListInteractorInput: AnyObject {
  func fetchTasks()
  func deleteTaskAt(_ row: Int)
  func changeStatusOfTaskAt(_ row: Int)
  func editTaskAt(_ row: Int)
  func shareTaskAt(_ row: Int)
  func didSearchWith(_ searchString: String)
  func didFinishSearch()
}

enum CuError: Error {
  case custon
}

protocol TodoListInteractorOutput: AnyObject {
  func showTasks(_ tasks: [TaskItem])
  func updateTasks(_ tasks: [TaskItem], animated: Bool)
  func editTask(_ task: TaskItem)
  func share(task: TaskItem)
  func showError(_ error: Error)
}

class TodoListInteractor: TodoListInteractorInput {

  weak var presenter: TodoListInteractorOutput?

  private let networkManager: NetwokManager = NetwokManager(with: .default)
  private let converter = TodosDomainToModelConverter()

  private var tasks: [TaskItem] = []
  private var filteredTasks: [TaskItem] = []

  func fetchTasks() {
    Task {
      do {
        let response = try await networkManager.obtainTasks()
        tasks = converter.convert(response)
        presenter?.showTasks(tasks)
      }
      catch {
        presenter?.showError(error)
      }
    }
  }

  func deleteTaskAt(_ row: Int) {
    // TODO: write realization
    tasks.remove(at: row)
    presenter?.updateTasks(tasks, animated: true)
  }

  func changeStatusOfTaskAt(_ row: Int) {
    // TODO: write realization
    tasks[row].isCompleted.toggle()
    presenter?.updateTasks(tasks, animated: false)
  }

  func editTaskAt(_ row: Int) {
    let task = tasks[row]
    presenter?.editTask(task)
  }

  func shareTaskAt(_ row: Int) {
    let task = tasks[row]
    presenter?.share(task: task)
  }

  func didSearchWith(_ searchString: String) {
    guard !searchString.isEmpty else {
      presenter?.updateTasks(tasks, animated: false)
      return
    }
    
    filteredTasks = tasks.filter({$0.title.lowercased().prefix(searchString.count) == searchString.lowercased() || $0.description.lowercased().prefix(searchString.count) == searchString.lowercased()})
    presenter?.updateTasks(filteredTasks, animated: false)
  }

  func didFinishSearch() {
    filteredTasks = []
    presenter?.updateTasks(tasks, animated: false)
  }

//  func getToolBarLabelText() -> String? {
//    let count = tasks.count
//    let lastNumber = count % 10
//    switch lastNumber {
//    case 0, 5...9:
//      return "\(count) Задач"
//    case 1:
//      return "\(count) Задача"
//    case 2...4:
//      return "\(count) Задачи"
//    default:
//      return nil
//    }
//  }
}

