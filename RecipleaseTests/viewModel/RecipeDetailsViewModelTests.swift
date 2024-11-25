//
//  RecipeDetailsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 08/11/2024.
//

import XCTest
@testable import Reciplease

final class RecipeDetailsViewModelTests: XCTestCase {
    func testAddRecipeToFavorites() {
        let viewModel = RecipeDetailsViewModel(dataProvider: RecipeDataProviderMock())

        let recipe = Recipe(
            uri: "recipe.com",
            label: "Pasta bolognese",
            image: "image.png",
            source: "google",
            url: "google.com",
            ingredients: [],
            totalTime: 60,
            tags: ["pasta", "tomato", "meat"],
            instructions: ["Cook pasta", "Cook sauce", "Mix pasta and sauce"]
        )

        viewModel.addRecipeToFavorites(recipe: recipe)

        let recipeIsContained = viewModel.dataProvider.isRecipeInFavorites(recipe: recipe)

        XCTAssertTrue(recipeIsContained)
    }

    func testRemoveRecipeFromFavorites() {
        let viewModel = RecipeDetailsViewModel(dataProvider: RecipeDataProviderMock())

        let recipe = Recipe(
            uri: "recipe.com",
            label: "Pasta bolognese",
            image: "image.png",
            source: "google",
            url: "google.com",
            ingredients: [],
            totalTime: 60,
            tags: ["pasta", "tomato", "meat"],
            instructions: ["Cook pasta", "Cook sauce", "Mix pasta and sauce"]
        )

        viewModel.addRecipeToFavorites(recipe: recipe)

        let recipeIsContained = viewModel.dataProvider.isRecipeInFavorites(recipe: recipe)

        XCTAssertTrue(recipeIsContained)

        viewModel.removeRecipeFromFavorites(recipe: recipe)

        let recipeNotContained = !viewModel.dataProvider.isRecipeInFavorites(recipe: recipe)

        XCTAssertTrue(recipeNotContained)
    }
}
