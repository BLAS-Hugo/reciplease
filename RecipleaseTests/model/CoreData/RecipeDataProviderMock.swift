//
//  RecipeDataProviderMock.swift
//  RecipleaseTests
//
//  Created by Hugo Blas on 12/11/2024.
//

import Foundation
import XCTest
@testable import Reciplease
import Testing

class RecipeDataProviderMock: RecipeDataProviding {
    private var favorites: [RecipeCoreData] = []
    var addToFavoritesCallCount = 0
    var removeFromFavoritesCallCount = 0
    var isRecipeInFavoritesCallCount = 0
    var getRecipesInFavoriteCallCount = 0

    private let coreDataStack: TestCoreDataStack

    var shouldThrowError = false
    enum MockError: Error {
        case simulatedError
    }

    init() {
        self.coreDataStack = TestCoreDataStack()
    }

    func isRecipeInFavorites(recipe: Recipe) -> Bool {
        isRecipeInFavoritesCallCount += 1
        return favorites.contains(where: { $0.id == recipe.id })
    }

    func isRecipeInFavorites(recipe: RecipeCoreData) -> Bool {
        isRecipeInFavoritesCallCount += 1
        return favorites.contains(where: { $0.id == recipe.id })
    }

    func addRecipeToFavorites(recipe: Recipe) throws {
        addToFavoritesCallCount += 1
        if shouldThrowError {
            throw MockError.simulatedError
        }

        let context = coreDataStack.persistentContainer.viewContext
        let mockRecipeCoreData = RecipeCoreData(context: context)
        mockRecipeCoreData.id = recipe.id
        mockRecipeCoreData.url = recipe.url
        mockRecipeCoreData.label = recipe.label
        mockRecipeCoreData.imageUrl = recipe.image

        try context.save()
        favorites.append(mockRecipeCoreData)
    }

    func addRecipeToFavorites(recipe: RecipeCoreData) throws {
        addToFavoritesCallCount += 1
        if shouldThrowError {
            throw MockError.simulatedError
        }

        let context = coreDataStack.persistentContainer.viewContext
        let newRecipe = RecipeCoreData(context: context)
        newRecipe.id = recipe.id
        newRecipe.url = recipe.url
        newRecipe.label = recipe.label
        newRecipe.imageUrl = recipe.imageUrl

        try context.save()
        favorites.append(newRecipe)
    }

    func removeRecipeFromFavorites(recipe: Recipe) {
        removeFromFavoritesCallCount += 1
        favorites.removeAll(where: { $0.id == recipe.id })
    }

    func removeRecipeFromFavorites(recipe: RecipeCoreData) {
        removeFromFavoritesCallCount += 1
        favorites.removeAll(where: { $0.id == recipe.id })
    }

    func getRecipesInFavorite() -> [RecipeCoreData]? {
        getRecipesInFavoriteCallCount += 1
        return favorites
    }

    func reset() {
        favorites.removeAll()
        addToFavoritesCallCount = 0
        removeFromFavoritesCallCount = 0
        isRecipeInFavoritesCallCount = 0
        getRecipesInFavoriteCallCount = 0
        shouldThrowError = false
    }
}
