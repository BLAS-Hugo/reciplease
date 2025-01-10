//
//  NetworkSessionMock.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import Foundation
@testable import Reciplease

class MockNetworkSession: NetworkSession {
    private let mockResponseFileName = "MockRecipeResponse"

    override func getRecipeWithKeyword(queries: [String]) async throws -> RecipeResponse {
        if shouldThrowError {
            throw NetworkError.invalidResponse
        }

        let bundle = Bundle(for: MockNetworkSession.self)
        let url = bundle.url(forResource: mockResponseFileName, withExtension: "json")

        let data = try Data(contentsOf: url!)
        let jsonDecoder = JSONDecoder()
        let recipes = try jsonDecoder.decode(RecipeResponse.self, from: data)
        return recipes
    }
}
