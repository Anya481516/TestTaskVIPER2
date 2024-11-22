//
//  TodoListRouter.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 20.11.2024.
//

import Foundation
import UIKit

protocol TodoListRouterInput: AnyObject {
  func navigateToTaskDetail(for task: TaskItem)
  func navigateToNewTask()
  func share(task: TaskItem)
  func showError(_ error: Error)
}

class TodoListRouter: TodoListRouterInput {

  weak var view: UIViewController?

  func navigateToTaskDetail(for task: TaskItem) {
    // TODO: write realization

    let taskViewController = TaskAssembly.buildTaskModule(task: task, type: .existing)
    view?.show(taskViewController, sender: nil)
  }

  func navigateToNewTask() {
    let taskViewController = TaskAssembly.buildTaskModule(type: .new)
    view?.show(taskViewController, sender: nil)
  }

  func share(task: TaskItem) {
    let label = task.title
    let description = task.description
    let date = task.date ?? ""

    let activityViewController : UIActivityViewController = UIActivityViewController(
        activityItems: [label, description, date], applicationActivities: nil)

    // This lines is for the popover you need to show in iPad
    //activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

    // This line remove the arrow of the popover to show in iPad
//    activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
//    activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
//
//    // Pre-configuring activity items
//    activityViewController.activityItemsConfiguration = [
//    UIActivity.ActivityType.message
//    ] as? UIActivityItemsConfigurationReading
//
//    // Anything you want to exclude
//    activityViewController.excludedActivityTypes = [
//        UIActivity.ActivityType.postToWeibo,
//        UIActivity.ActivityType.print,
//        UIActivity.ActivityType.assignToContact,
//        UIActivity.ActivityType.saveToCameraRoll,
//        UIActivity.ActivityType.addToReadingList,
//        UIActivity.ActivityType.postToFlickr,
//        UIActivity.ActivityType.postToVimeo,
//        UIActivity.ActivityType.postToTencentWeibo,
//        UIActivity.ActivityType.postToFacebook
//    ]

    activityViewController.isModalInPresentation = true
    view?.present(activityViewController, animated: true, completion: nil)
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
      self.view?.dismiss(animated: true)
    }

    alert.addAction(okAction)

    DispatchQueue.main.async { [weak self] in
      self?.view?.present(alert, animated: true)
    }
  }
}
