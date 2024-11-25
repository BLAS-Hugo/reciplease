//
//  NetworkSession.swift
//  Reciplease
//
//  Created by Hugo Blas on 06/09/2024.
//

import Foundation
import Alamofire

class NetworkSession {
    private let APP_ID = "975cce4c"
    private let APP_KEY = "23877f06cc27dfe8d932fb377fa8b6f0"

    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
    }

    func getRecipeWithKeyword(queries: [String]) async throws -> RecipeResponse {
        do {
            let parameters = [
                "type": "public",
                "app_id": APP_ID,
                "app_key": APP_KEY,
                "q": "\(queries)"
            ]
            let response = try await AF.request("https://api.edamam.com/api/recipes/v2", method: .get, parameters: parameters).serializingData().value
            let jsonDecoder = JSONDecoder()
            let recipes = try jsonDecoder.decode(RecipeResponse.self, from: response)
            return recipes
        } catch {
            throw NetworkError.invalidResponse
        }
    }

    func getDirections(for recipe: Recipe) async throws -> String {
        do {
            let response = try await AF.request(recipe.url, method: .get).serializingData().value
            print(response)
            return ""
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
