//
//  IngredientList.swift
//  Reciplease
//
//  Created by Hugo Blas on 12/09/2024.
//

import Foundation

class IngredientList {
    static let shared = IngredientList()

    private init() {}

    private var ingredients: Set<String> = []

    // Adds an ingredient if it doesn't already exist
    func add(ingredient: String) {
        if ingredients.insert(ingredient).inserted {
            print("Added ingredient: \(ingredient)")
        } else {
            print("Ingredient already exists: \(ingredient)")
        }
    }

    // Clears all ingredients
    func clear() {
        ingredients.removeAll()
    }

    // Checks if an ingredient exists
    func contains(ingredient: String) -> Bool {
        return ingredients.contains(ingredient)
    }

    // Returns all ingredients as an array
    func getAllIngredients() -> [String] {
        return Array(ingredients)
    }
}
