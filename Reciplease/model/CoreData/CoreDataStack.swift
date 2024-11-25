//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Hugo Blas on 12/09/2024.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let sharedInstance = CoreDataStack()

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var recipeEntity: NSEntityDescription = {
        return NSEntityDescription.entity(forEntityName: "RecipeCoreData", in: viewContext)!
    }()
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
