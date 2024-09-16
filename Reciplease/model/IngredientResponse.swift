//
//  Ingredient.swift
//  Reciplease
//
//  Created by Hugo Blas on 12/09/2024.
//

import Foundation
import CoreData

class IngredientResponse: Codable {
    enum IngredientCodingKeys: CodingKey {
        case text
        case quantity
        case measure
        case food
        case weight
        case foodId
      }
}
