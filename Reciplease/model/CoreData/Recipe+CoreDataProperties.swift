//
//  Recipe+CoreDataProperties.swift
//  
//
//  Created by Hugo Blas on 13/09/2024.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var numberOfLikes: Int16
    @NSManaged public var instructions: NSObject?
    @NSManaged public var cookingTime: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var uri: String?
    @NSManaged public var label: String?
    @NSManaged public var yield: Int16
    @NSManaged public var calories: Int16
    @NSManaged public var ingredients: NSObject?

}
