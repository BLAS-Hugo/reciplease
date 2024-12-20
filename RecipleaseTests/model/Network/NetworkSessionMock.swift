//
//  NetworkSessionMock.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import Foundation
import Alamofire

class MockNetworkSession: NetworkSession {

    private let mockResponseFileName = "MockRecipeResponse.json"

    override func getRecipeWithKeyword(queries: [String]) async throws -> RecipeResponse {
        guard let url = Bundle.main.url(forResource: mockResponseFileName, withExtension: nil) else {
            throw NetworkError.invalidURL
        }

        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let recipes = try jsonDecoder.decode(RecipeResponse.self, from: data)
        return recipes
    }

    override func getDirections(for recipe: Recipe) async throws -> String {
        return "Mock directions for \(recipe.label)"
    }
}
