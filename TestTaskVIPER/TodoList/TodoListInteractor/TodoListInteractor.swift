//
//  TodoListInteractor.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

protocol TodoListInteractorInput: AnyObject {
  func viewDidLoad()
  func viewWillAppear()
  func deleteTaskAt(_ row: Int)
  func changeStatusOfTaskAt(_ row: Int)
  func editTaskAt(_ row: Int)
  func shareTaskAt(_ row: Int)
  func didSearchWith(_ searchString: String)
  func didFinishSearch()
  func didTapNewTask()
  func getToolBarLabelText(for taskCount: Int) -> String?
  func getTask(_ row: Int) -> TodoTask
  func getTasksCount() -> Int
}

enum CuError: Error {
  case custon
}

protocol TodoListInteractorOutput: AnyObject {
  func showTasks(_ tasks: [TodoTask])
  func updateTasks(_ tasks: [TodoTask], animated: Bool)
  func editTask(_ task: TodoTask)
  func share(task: TodoTask)
  func showError(_ error: Error)
  func createNewTask(_ task: TodoTask)
}

class TodoListInteractor: TodoListInteractorInput {

  weak var presenter: TodoListInteractorOutput?

  private let networkManager: NetwokManager = NetwokManager(with: .default)
  private let converter = TodosDomainToModelConverter()

  private var tasks: [TodoTask] = []
  private var filteredTasks: [TodoTask] = []

  lazy var coreDataManager = CoreDataManager.shared

  func viewDidLoad() {
    let savedTasks = coreDataManager.obtainData()
    if !savedTasks.isEmpty {
      tasks = savedTasks
      presenter?.showTasks(tasks)
    }
    else {
      Task {
        do {
          let response = try await networkManager.obtainTasks()
          tasks = converter.convert(response)
          coreDataManager.saveContext()
          presenter?.showTasks(tasks)
        }
        catch {
          presenter?.showError(error)
        }
      }
    }
  }

  func viewWillAppear() {
    let savedTasks = coreDataManager.obtainData()
    tasks = savedTasks
    presenter?.showTasks(tasks)
  }

  func deleteTaskAt(_ row: Int) {
    coreDataManager.delete(tasks.remove(at: row))
    presenter?.updateTasks(tasks, animated: true)
  }

  func changeStatusOfTaskAt(_ row: Int) {
    guard row < tasks.count else { return }
    tasks[row].isCompleted.toggle()
    coreDataManager.saveContext()
    presenter?.updateTasks(tasks, animated: false)
  }

  func editTaskAt(_ row: Int) {
    guard row < tasks.count else { return }
    let task = tasks[row]
    presenter?.editTask(task)
  }

  func shareTaskAt(_ row: Int) {
    guard row < tasks.count else { return }
    let task = tasks[row]
    presenter?.share(task: task)
  }

  func didTapNewTask() {
    let task = TodoTask(context: coreDataManager.persistentContainer.viewContext)
    task.id = UUID().uuidString
    task.title = ""
    task.taskDescription = ""
    task.isCompleted = false
    task.date = Date()

    presenter?.createNewTask(task)
  }

  func didSearchWith(_ searchString: String) {
    guard !searchString.isEmpty else {
      presenter?.updateTasks(tasks, animated: false)
      return
    }
    
    filteredTasks = tasks.filter({$0.title.lowercased().contains(searchString.lowercased()) || $0.description.lowercased().contains(searchString.lowercased())})
    presenter?.updateTasks(filteredTasks, animated: false)
  }

  func didFinishSearch() {
    filteredTasks = []
    presenter?.updateTasks(tasks, animated: false)
  }

  func getToolBarLabelText(for taskCount: Int) -> String? {
    let lastNumber = taskCount % 10
    switch lastNumber {
    case 0, 5...9:
      return "\(taskCount) Задач"
    case 1:
      return "\(taskCount) Задача"
    case 2...4:
      return "\(taskCount) Задачи"
    default:
      return nil
    }
  }

  func getTask(_ row: Int) -> TodoTask {
    return tasks[row]
  }

  func getTasksCount() -> Int {
    return tasks.count
  }
}

