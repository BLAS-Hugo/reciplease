//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by Hugo Blas on 16/09/2024.
//

import Foundation

class RecipeRepository {
    let session: NetworkSession

    init(session: NetworkSession) {
        self.session = session
    }

    func getRecipeWithKeywords(_ queries: [String]) async throws -> RecipeResponse {
            let recipes = try await session.getRecipeWithKeyword(queries: queries)

            return recipes
    }
}
