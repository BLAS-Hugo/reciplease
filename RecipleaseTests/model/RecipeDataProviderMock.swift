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
    func isRecipeInFavorites(recipe: Recipe) -> Bool {
        return recipes.contains(where: {
            return $0.url == recipe.url
        })
    }

    func addRecipeToFavorites(recipe: Recipe) {
        if isRecipeInFavorites(recipe: recipe) {
            return
        }

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        let recipeCoreData = RecipeCoreData(context: context)
        recipeCoreData.url = recipe.url
        recipeCoreData.label = recipe.label

        try! context.save()
    }

    func removeRecipeFromFavorites(recipe: Recipe) {
        if isRecipeInFavorites(recipe: recipe) {
            recipes.removeAll(where: {
                $0.url == recipe.url
            })
        }
    }

    func addRecipeToFavorites(recipe: RecipeCoreData) {
        if isRecipeInFavorites(recipe: recipe) {
            return
        }

        favoritesRecipes.append(recipe)
    }

    func removeRecipeFromFavorites(recipe: RecipeCoreData) {
        if isRecipeInFavorites(recipe: recipe) {
            favoritesRecipes.removeAll(where: {
                $0.url == recipe.url
            })
        }
    }

    func isRecipeInFavorites(recipe: RecipeCoreData) -> Bool {
        return favoritesRecipes.contains(where: {
            return $0.url == recipe.url
        })
    }

    func getRecipesInFavorite() -> [RecipeCoreData]? {
        return favoritesRecipes
    }
}
