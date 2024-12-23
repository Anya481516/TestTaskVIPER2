//
//  File.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

protocol TodoListPresenterInput: AnyObject {
  func viewDidLoad()
  func viewWillAppear()
  func didTapEditTaskAt(_ row: Int)
  func didTapShareTaskAt(_ row: Int)
  func didTapDeleteTaskAt(_ row: Int)
  func didTapTaskAt(_ row: Int)
  func didTapNewTask()
  func didSearchWith(_ searchString: String)
  func didFinishSearch()
  func getToolBarLabelText() -> String?
  func getTask(_ row: Int) -> TodoTask
  func getTasksCount() -> Int
}

protocol TodoListPresenterOutput: AnyObject {
  func updateUI()
}

class TodoListPresenter: TodoListPresenterInput, TodoListInteractorOutput {
  weak var view: TodoListPresenterOutput!
  var interactor: TodoListInteractorInput!
  var router: TodoListRouterInput!
  
  func viewDidLoad() {
    interactor.viewDidLoad()
  }
  
  func viewWillAppear() {
    interactor.viewWillAppear()
  }
  
  func didTapTaskAt(_ row: Int) {
    interactor.changeStatusOfTaskAt(row)
  }
  
  func didTapEditTaskAt(_ row: Int) {
    interactor.editTaskAt(row)
  }
  
  func didTapShareTaskAt(_ row: Int) {
    interactor.shareTaskAt(row)
  }
  
  func didTapDeleteTaskAt(_ row: Int) {
    interactor.deleteTaskAt(row)
  }
  
  func didTapNewTask() {
    interactor.didTapNewTask()
  }
  
  func didSearchWith(_ searchString: String) {
    interactor.didSearchWith(searchString)
  }
  
  func didFinishSearch() {
    interactor.didFinishSearch()
  }
  
  func getToolBarLabelText() -> String? {
    interactor.getToolBarLabelText(for: interactor.getTasksCount())
  }
  
  func getTask(_ row: Int) -> TodoTask {
    interactor.getTask(row)
  }
  
  func getTasksCount() -> Int {
    interactor.getTasksCount()
  }
  
  
  func showTasks() {
    view.updateUI()
  }
  
  func editTask(_ task: TodoTask) {
    router.navigateToTaskDetail(for: task)
  }
  
  func share(task: TodoTask) {
    router.share(task: task)
  }
  
  func showError(_ error: Error) {
    router.showError(error)
  }
  
  func createNewTask(_ task: TodoTask) {
    router.navigateToNewTask(task)
  }
}
