//
//  FavoritesListViewModel.swift
//  Reciplease
//
//  Created by Hugo Blas on 15/11/2024.
//

import Foundation

class FavoritesListViewModel {
    let dataProvider: RecipeDataProviding

    init(dataProvider: RecipeDataProviding) {
        self.dataProvider = dataProvider
    }

     func addRecipeToFavorites(recipe: RecipeCoreData) {
         dataProvider.addRecipeToFavorites(recipe: recipe)
     }

    func removeRecipeFromFavorites(recipe: RecipeCoreData) {
        dataProvider.removeRecipeFromFavorites(recipe: recipe)
    }

    func getRecipesInFavorite() -> [RecipeCoreData] {
        return dataProvider.getRecipesInFavorite() ?? []
    }
}
