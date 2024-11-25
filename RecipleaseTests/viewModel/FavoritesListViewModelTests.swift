//
//  FavoritesListViewModelTests.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 15/11/2024.
//

import XCTest
@testable import Reciplease

final class FavoritesListViewModelTests: XCTestCase {
    func testAddToFavorites() {
        let viewModel = FavoritesListViewModel(dataProvider: RecipeDataProviderMock())
        let recipe = RecipeCoreData()

        recipe.setValue("testUrl.com", forKey: "url")

        viewModel.addRecipeToFavorites(recipe: recipe)

        XCTAssertTrue(viewModel.dataProvider.isRecipeInFavorites(recipe: recipe))
    }

    func testRemoveFromFavorites() {
        let viewModel = FavoritesListViewModel(dataProvider: RecipeDataProviderMock())
        let recipe = RecipeCoreData()

        recipe.setValue("testUrl.com", forKey: "url")

        viewModel.removeRecipeFromFavorites(recipe: recipe)

        XCTAssertFalse(viewModel.dataProvider.isRecipeInFavorites(recipe: recipe))
    }
}
