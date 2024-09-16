//
//  Recipe.swift
//  Reciplease
//
//  Created by Hugo Blas on 06/09/2024.
//

import Foundation
import CoreData

class RecipeResponse: Codable {
    enum RecipeCodingKeys: CodingKey {
        case label
        case uri
        case numberOfLikes
        case yield
        case calories
        case cookingTime
        case ingredients
        case instructions
        case imageUrl
      }
}
