//
//  RecipeDataProvider.swift
//  Reciplease
//
//  Created by Hugo Blas on 14/11/2024.
//

import Foundation

class RecipeDataProvider: RecipeDataProviding {
    func isRecipeInFavorites(recipe: RecipeCoreData) -> Bool {
        let favorites = getRecipesInFavorite() ?? []
        return favorites.contains(where: { $0.id == recipe.id })
    }

    func isRecipeInFavorites(recipe: Recipe) -> Bool {
        let favorites = getRecipesInFavorite() ?? []
        return favorites.contains(where: { $0.id == recipe.id })
    }

    func addRecipeToFavorites(recipe: Recipe) {
        guard !isRecipeInFavorites(recipe: recipe) else { return }
        let instance = CoreDataStack.sharedInstance

        _ = recipe.insert(into: instance.viewContext)

        if instance.viewContext.hasChanges {
            try? instance.viewContext.save()
        }
    }
    func addRecipeToFavorites(recipe: RecipeCoreData) {
        guard !isRecipeInFavorites(recipe: recipe) else { return }

        let instance = CoreDataStack.sharedInstance
        _ = Recipe.fromCoreData(recipe: recipe).insert(into: instance.viewContext)
        
        if instance.viewContext.hasChanges {
            try? instance.viewContext.save()
        }
    }

    func removeRecipeFromFavorites(recipe: RecipeCoreData) {
        guard isRecipeInFavorites(recipe: recipe) else { return }
        let instance = CoreDataStack.sharedInstance

        instance.viewContext.delete(recipe)
    }

    func removeRecipeFromFavorites(recipe: Recipe) {
        let instance = CoreDataStack.sharedInstance

        let recipeCoreData = RecipeCoreData(context: instance.viewContext)

        recipeCoreData.setValue(recipe.label, forKey: "label")
        recipeCoreData.setValue(recipe.url, forKey: "url")

        guard isRecipeInFavorites(recipe: recipe) else { return }

        instance.viewContext.delete(recipeCoreData)
    }

    func getRecipesInFavorite() -> [RecipeCoreData]? {
        let instance = CoreDataStack.sharedInstance

        let fetchRequest = RecipeCoreData.fetchRequest()

        let context = instance.viewContext

        return try! context.fetch(fetchRequest)
    }
}
