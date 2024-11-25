//
//  RecipeCoreData+CoreDataProperties.swift
//  
//
//  Created by Hugo Blas on 20/11/2024.
//
//

import Foundation
import CoreData


extension RecipeCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCoreData> {
        return NSFetchRequest<RecipeCoreData>(entityName: "RecipeCoreData")
    }

    @NSManaged public var cookingTime: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingredients: Array<String>?
    @NSManaged public var label: String?
    @NSManaged public var url: String?
    @NSManaged public var id: String

}
