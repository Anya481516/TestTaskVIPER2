//
//  TodoTask+CoreDataProperties.swift
//  TestTaskVIPER
//
//  Created by Nikita Komarov on 22.11.2024.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var taskDescription: String?
    @NSManaged public var date: String?
    @NSManaged public var isCompleted: Bool

}

extension TodoTask : Identifiable {

}
