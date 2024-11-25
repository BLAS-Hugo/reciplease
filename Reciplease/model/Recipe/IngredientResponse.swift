    //
    //  IngredientResponse.swift
    //  Reciplease
    //
    //  Created by Hugo Blas on 12/09/2024.
    //

    import Foundation
    import CoreData

    struct IngredientResponse: Decodable {
        let text: String
        enum IngredientCodingKeys: CodingKey {
            case text
            case quantity
            case measure
            case food
            case weight
            case foodId
          }
    }

    class IngredientList {
        static let shared = IngredientList()

        private init() {}

           private(set) var ingredients: [String] = []

           func add(ingredient: String) {
               ingredients.append(ingredient)
               print(ingredients)
           }

        func clear() {
            ingredients.removeAll()
        }
    }
