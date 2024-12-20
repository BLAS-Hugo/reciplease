//
//  RecipeDataProviding.swift
//  Reciplease
//
//  Created by Hugo Blas on 14/11/2024.
//

import Foundation
protocol RecipeDataProviding {
    func addRecipeToFavorites(recipe: Recipe) throws
    func addRecipeToFavorites(recipe: RecipeCoreData) throws
    func removeRecipeFromFavorites(recipe: Recipe)
    func removeRecipeFromFavorites(recipe: RecipeCoreData)
    func isRecipeInFavorites(recipe: RecipeCoreData) -> Bool
    func isRecipeInFavorites(recipe: Recipe) -> Bool
    func getRecipesInFavorite() -> [RecipeCoreData]?
}
