//
//  NetworkSessionMock.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import Foundation
@testable import Reciplease

class MockNetworkSession: NetworkSession {
    private let mockResponseFileName = "MockRecipeResponse.json"

    override func getRecipeWithKeyword(queries: [String]) async throws -> RecipeResponse {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        }

        guard let url = Bundle.main.url(forResource: mockResponseFileName, withExtension: nil) else {
            throw NetworkError.invalidURL
        }

        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let recipes = try jsonDecoder.decode(RecipeResponse.self, from: data)
        return recipes
    }
}
