//
//  RecipeRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 20/12/2024.
//

import XCTest
@testable import Reciplease

final class RecipeRepositoryTests: XCTestCase {
    var repository: RecipeRepository!
    var mockNetworkSession: MockNetworkSession!

    override func setUp() {
        super.setUp()
        mockNetworkSession = MockNetworkSession()
        repository = RecipeRepository(session: mockNetworkSession)
    }

    override func tearDown() {
        mockNetworkSession = nil
        repository = nil
        super.tearDown()
    }

    func testGetRecipeWithKeywords() async {
        // Given
        let queries = ["Pasta"]

        // When
        do {
            let response = try await repository.getRecipeWithKeywords(queries)

            // Then
            XCTAssertEqual(response.hits.count, 1)
            XCTAssertEqual(response.hits[0].recipe.label, "Pasta")
            XCTAssertEqual(response.hits[0].recipe.id, "1")
        } catch {
            XCTFail("Expected successful response, but got error: \(error)")
        }
    }

    func testGetDirections() async {
        // Given
        let recipe = Recipe(
            id: "1",
            label: "Pasta",
            image: "pasta.png",
            url: "http://example.com/pasta",
            ingredients: [],
            totalTime: 30,
            isFavorite: false
        )

        // When
        do {
            let directions = try await repository.getDirections(for: recipe)

            // Then
            XCTAssertEqual(directions, "Mock directions for Pasta")
        } catch {
            XCTFail("Expected successful response, but got error: \(error)")
        }
    }

    func testGetRecipeWithKeywordsInvalidResponse() async {
        // Given
        mockNetworkSession.shouldThrowError = true

        // When
        do {
            _ = try await repository.getRecipeWithKeywords(["Pasta"])
            XCTFail("Expected an error to be thrown")
        } catch {
            XCTAssertEqual(error as? NetworkSession.NetworkError, .invalidResponse)
        }
    }
}
