//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Hugo Blas on 25/10/2024.
//

import Foundation

class RecipeDetailsViewModel {
    let dataProvider: RecipeDataProviding

    init(dataProvider: RecipeDataProviding) {
        self.dataProvider = dataProvider
    }

     func addRecipeToFavorites(recipe: Recipe) throws {
         try dataProvider.addRecipeToFavorites(recipe: recipe)
     }
    

    func removeRecipeFromFavorites(recipe: Recipe) {
        dataProvider.removeRecipeFromFavorites(recipe: recipe)
    }

    func getRecipesInFavorite() -> [RecipeCoreData] {
        return dataProvider.getRecipesInFavorite() ?? []
    }
}
