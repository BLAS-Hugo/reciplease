//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Hugo Blas on 16/09/2024.
//

import Foundation

class RecipeRepository {
    let session = NetworkSession()

    func getRecipeWithKeywords(_ queries: [String]) async throws -> RecipeResponse {
            let recipes = try await session.getRecipeWithKeyword(queries: queries)

            return recipes
    }

    func getDirections(for recipe: Recipe) async throws -> String{
        let directions = try await session.getDirections(for: recipe)

        return directions
    }
}
