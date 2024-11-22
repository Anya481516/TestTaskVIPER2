//
//  TodoListAssembly.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import UIKit

class TodoListAssembly {
  static func buildTodoListModule() -> UIViewController {
    let view = TodoListViewController()
    let interactor = TodoListInteractor()
    let presenter = TodoListPresenter()
    let router = TodoListRouter()

    view.presenter = presenter

    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router

    interactor.presenter = presenter

    router.view = view
    router.presenter = presenter

    return view
  }

  private init() {}
}
