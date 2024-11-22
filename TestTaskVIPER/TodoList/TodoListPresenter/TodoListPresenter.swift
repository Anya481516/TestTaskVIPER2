//
//  File.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation

protocol TodoListPresenterInput: AnyObject {
  func viewDidLoad()
  func didTapEditTaskAt(_ row: Int)
  func didTapShareTaskAt(_ row: Int)
  func didTapDeleteTaskAt(_ row: Int)
  func didTapTaskAt(_ row: Int)
  func didTapNewTask()
  func didSearchWith(_ searchString: String)
  func didFinishSearch()
}

protocol TodoListPresenterOutput: AnyObject {
  func updateUI(with tasks: [TaskItem], animated: Bool)
}

class TodoListPresenter: TodoListPresenterInput, TodoListInteractorOutput {

  weak var view: TodoListPresenterOutput?
  var interactor: TodoListInteractorInput?
  var router: TodoListRouterInput?

  func viewDidLoad() {
    interactor?.fetchTasks()
  }

  func didTapTaskAt(_ row: Int) {
    interactor?.changeStatusOfTaskAt(row)
  }

  func didTapEditTaskAt(_ row: Int) {
    interactor?.editTaskAt(row)
  }

  func didTapShareTaskAt(_ row: Int) {
    interactor?.shareTaskAt(row)
  }

  func didTapDeleteTaskAt(_ row: Int) {
    interactor?.deleteTaskAt(row)
  }

  func didTapNewTask() {
    router?.navigateToNewTask()
  }

  func didSearchWith(_ searchString: String) {
    interactor?.didSearchWith(searchString)
  }

  func didFinishSearch() {
    interactor?.didFinishSearch()
  }


  func showTasks(_ tasks: [TaskItem]) {
    view?.updateUI(with: tasks, animated: false)
  }

  func updateTasks(_ tasks: [TaskItem], animated: Bool) {
    view?.updateUI(with: tasks, animated: animated)
  }

  func editTask(_ task: TaskItem) {
    router?.navigateToTaskDetail(for: task)
  }

  func share(task: TaskItem) {
    router?.share(task: task)
  }

  func showError(_ error: Error) {
    router?.showError(error)
  }
}
