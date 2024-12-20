//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Hugo Blas on 06/09/2024.

import Foundation
import CoreData

// MARK: - RecipeResponse
struct RecipeResponse: Decodable {
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case hits
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let id: String
    let label: String
    let image: String
    let url: String
    let ingredients: [Ingredient]
    let totalTime: Int
    let isFavorite: Bool

    enum CodingKeys: CodingKey {
        case id
        case label
        case image
        case url
        case ingredients
        case totalTime
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.label = try container.decode(String.self, forKey: .label)
        self.image = try container.decode(String.self, forKey: .image)
        self.url = try container.decode(String.self, forKey: .url)
        self.ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        self.totalTime = try container.decode(Int.self, forKey: .totalTime)
        self.isFavorite = false
    }

    init(
        id: String,
        label: String,
        image: String,
        url: String,
        ingredients: [Ingredient],
        totalTime: Int,
        isFavorite: Bool
    ) {
        self.id = id
        self.label = label
        self.image = image
        self.url = url
        self.ingredients = ingredients
        self.totalTime = totalTime
        self.isFavorite = isFavorite
    }

    static func fromCoreData(recipe: RecipeCoreData) -> Recipe {
        let string = String(format: "%d", recipe.cookingTime)
        let totalTime = Int(string)
        let ingredients = (recipe.ingredients ?? []).map { food in
            Ingredient(
                text: food,
                quantity: 0,
                measure: nil,
                food: food,
                weight: 0,
                foodCategory: "",
                foodID: "",
                image: nil
            )
        }
      return Recipe(
        id: recipe.id!,
        label: recipe.label ?? "",
        image: recipe.imageUrl ?? "",
        url: recipe.url ?? "",
        ingredients: ingredients,
        totalTime: totalTime ?? 0,
        isFavorite: true
      )
    }

    func insert(into context: NSManagedObjectContext) -> RecipeCoreData {
        let recipeCoreData = RecipeCoreData(context: context)

        recipeCoreData.setValue(label, forKey: "label")
        recipeCoreData.setValue(id, forKey: "id")
        recipeCoreData.setValue(url, forKey: "url")
        recipeCoreData.setValue(image, forKey: "imageUrl")
        recipeCoreData.setValue(totalTime, forKey: "cookingTime")

        let ingredients = ingredients.map(\.self.food)
        recipeCoreData.setValue(ingredients, forKey: "ingredients")

        return recipeCoreData
    }
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory, foodID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}
