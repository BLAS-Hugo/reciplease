//
//  Ingredient+CoreDataProperties.swift
//  
//
//  Created by Hugo Blas on 13/09/2024.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var text: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var measure: String?
    @NSManaged public var food: String?
    @NSManaged public var weight: String?
    @NSManaged public var foodId: String?

}
