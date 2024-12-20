//
//  RecipeDetailsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 08/11/2024.
//

import XCTest
@testable import Reciplease

final class RecipeDetailsViewModelTests: XCTestCase {
    var viewModel: RecipeDetailsViewModel!
    var mockDataProvider: RecipeDataProviderMock!

    override func setUp() {
        super.setUp()
        mockDataProvider = RecipeDataProviderMock()
        viewModel = RecipeDetailsViewModel(dataProvider: mockDataProvider)
    }

    override func tearDown() {
        mockDataProvider.reset()
        mockDataProvider = nil
        viewModel = nil
        super.tearDown()
    }

    func testAddRecipeToFavorites() {
        // Given
        let recipe = Recipe(
            id: UUID().uuidString,
            label: "Pasta bolognese",
            image: "image.png",
            url: "recipe.com",
            ingredients: [],
            totalTime: 60,
            isFavorite: false
        )

        // When
        XCTAssertNoThrow(try viewModel.addRecipeToFavorites(recipe: recipe))

        // Then
        XCTAssertEqual(mockDataProvider.addToFavoritesCallCount, 1)
        XCTAssertTrue(mockDataProvider.isRecipeInFavorites(recipe: recipe))
    }

    func testAddRecipeToFavoritesWithError() {
        // Given
        let recipe = Recipe(
            id: UUID().uuidString,
            label: "Pasta bolognese",
            image: "image.png",
            url: "recipe.com",
            ingredients: [],
            totalTime: 60,
            isFavorite: false
        )
        mockDataProvider.shouldThrowError = true

        // When/Then
        XCTAssertThrowsError(try viewModel.addRecipeToFavorites(recipe: recipe)) { error in
            XCTAssertEqual(error as? RecipeDataProviderMock.MockError, .simulatedError)
        }
        XCTAssertEqual(mockDataProvider.addToFavoritesCallCount, 1)
        XCTAssertFalse(mockDataProvider.isRecipeInFavorites(recipe: recipe))
    }

    func testRemoveRecipeFromFavorites() {
        // Given
        let recipe = Recipe(
            id: UUID().uuidString,
            label: "Pasta bolognese",
            image: "image.png",
            url: "recipe.com",
            ingredients: [],
            totalTime: 60,
            isFavorite: true
        )
        try? mockDataProvider.addRecipeToFavorites(recipe: recipe)

        // When
        viewModel.removeRecipeFromFavorites(recipe: recipe)

        // Then
        XCTAssertEqual(mockDataProvider.removeFromFavoritesCallCount, 1)
        XCTAssertFalse(mockDataProvider.isRecipeInFavorites(recipe: recipe))
    }

    func testGetRecipesInFavorite() {
        // Given
        let recipe = Recipe(
            id: UUID().uuidString,
            label: "Pasta bolognese",
            image: "image.png",
            url: "recipe.com",
            ingredients: [],
            totalTime: 60,
            isFavorite: true
        )
        try? mockDataProvider.addRecipeToFavorites(recipe: recipe)

        // When
        let favorites = viewModel.getRecipesInFavorite()

        // Then
        XCTAssertEqual(mockDataProvider.getRecipesInFavoriteCallCount, 1)
        XCTAssertFalse(favorites.isEmpty)
        XCTAssertEqual(favorites.count, 1)
    }

    func testGetRecipesInFavoriteWhenEmpty() {
        // When
        let favorites = viewModel.getRecipesInFavorite()

        // Then
        XCTAssertEqual(mockDataProvider.getRecipesInFavoriteCallCount, 1)
        XCTAssertTrue(favorites.isEmpty)
    }
}
