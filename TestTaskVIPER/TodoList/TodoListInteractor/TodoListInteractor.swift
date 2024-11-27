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
  func showTasks()
  func editTask(_ task: TodoTask)
  func share(task: TodoTask)
  func showError(_ error: Error)
  func createNewTask(_ task: TodoTask)
}

class TodoListInteractor: TodoListInteractorInput {
  
  weak var presenter: TodoListInteractorOutput!
  
  private let networkManager: NetwokManager = NetwokManager(with: .default)
  private let converter = TodosDomainToModelConverter()
  
  private var tasks: [TodoTask] = []
  private var filteredTasks: [TodoTask] = []
  
  private lazy var coreDataManager = CoreDataManager.shared

  private var isSearching = false

  func viewDidLoad() {
    coreDataManager.obtainData { [weak self] savedTasks in
      self?.updateDataAfterLoading(savedTasks)
    }
  }

  private func updateDataAfterLoading(_ savedTasks: [TodoTask]) {
    if !savedTasks.isEmpty {
      tasks = savedTasks
      filteredTasks = tasks
      presenter.showTasks()
    }
    else {
      Task {
        do {
          let response = try await networkManager.obtainTasks()
          tasks = converter.convert(response)
          filteredTasks = tasks
          coreDataManager.saveContext()
          presenter.showTasks()
        }
        catch {
          presenter.showError(error)
        }
      }
    }
  }

  func viewWillAppear() {
    coreDataManager.obtainData() { [weak self] savedTasks in
      self?.updateDataAfterAppearing(savedTasks)
    }
  }

  private func updateDataAfterAppearing(_ savedTasks: [TodoTask]) {
    tasks = savedTasks
    if !isSearching {
      filteredTasks = tasks
    }
    presenter.showTasks()
  }

  func deleteTaskAt(_ row: Int) {
    let task = filteredTasks.remove(at: row)
    tasks.removeAll(where: { $0 == task })
    coreDataManager.delete(task)
    presenter.showTasks()
  }
  
  func changeStatusOfTaskAt(_ row: Int) {
    guard row < tasks.count else { return }
    filteredTasks[row].isCompleted.toggle()
    coreDataManager.saveContext()
    presenter.showTasks()
  }
  
  func editTaskAt(_ row: Int) {
    guard row < filteredTasks.count else { return }
    let task = filteredTasks[row]
    presenter.editTask(task)
  }
  
  func shareTaskAt(_ row: Int) {
    guard row < tasks.count else { return }
    let task = filteredTasks[row]
    presenter.share(task: task)
  }
  
  func didTapNewTask() {
    let task = TodoTask(context: coreDataManager.persistentContainer.viewContext)
    task.id = UUID().uuidString
    task.title = ""
    task.taskDescription = ""
    task.isCompleted = false
    task.date = Date()
    
    presenter.createNewTask(task)
  }
  
  func didSearchWith(_ searchString: String) {
    guard !searchString.isEmpty else {
      isSearching = false
      filteredTasks = tasks
      presenter.showTasks()
      return
    }
    isSearching = true
    filteredTasks = tasks.filter({$0.title.lowercased().contains(searchString.lowercased()) || $0.description.lowercased().contains(searchString.lowercased())})
    presenter.showTasks()
  }
  
  func didFinishSearch() {
    isSearching = false
    filteredTasks = tasks
    presenter.showTasks()
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
    return filteredTasks[row]
  }
  
  func getTasksCount() -> Int {
    return filteredTasks.count
  }
}
