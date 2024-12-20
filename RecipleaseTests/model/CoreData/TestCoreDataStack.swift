//
//  TestCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/11/2024.
//

import Foundation
import CoreData

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
