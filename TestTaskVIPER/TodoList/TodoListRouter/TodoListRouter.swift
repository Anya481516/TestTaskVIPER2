//
//  TodoListRouter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation
import UIKit

protocol TodoListRouterInput: AnyObject {
  func navigateToTaskDetail(for task: TodoTask)
  func navigateToNewTask(_ task: TodoTask)
  func share(task: TodoTask)
  func showError(_ error: Error)
}

class TodoListRouter: TodoListRouterInput {
  
  weak var view: UIViewController!
  //weak var presenter: TodoListInteractorOutput!
  
  func navigateToTaskDetail(for task: TodoTask) {
    let taskViewController = TaskAssembly.buildTaskModule(task: task, type: .existing)
    view.show(taskViewController, sender: nil)
  }
  
  func navigateToNewTask(_ task: TodoTask) {
    let taskViewController = TaskAssembly.buildTaskModule(task: task, type: .new)
    view.show(taskViewController, sender: nil)
  }
  
  func share(task: TodoTask) {
    let label = task.title
    let description = task.taskDescription
    let date = task.date.getFormattedDate(format: "dd/MM/yyy")
    
    let activityViewController : UIActivityViewController = UIActivityViewController(
      activityItems: [label, description, date], applicationActivities: nil)
    
    activityViewController.isModalInPresentation = true
    view.present(activityViewController, animated: true, completion: nil)
  }
  
  func showError(_ error: Error) {
    let alert = UIAlertController(
      title: "Something went wrong",
      message: "Error when obtaining tasks: \(error)",
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(
      title: "Ok",
      style: .default
    ) { action in
      self.view.dismiss(animated: true)
    }
    
    alert.addAction(okAction)
    
    DispatchQueue.main.async { [weak self] in
      self?.view.present(alert, animated: true)
    }
  }
}
