//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Hugo Blas on 10/10/2024.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {
    static let cellIdentifier = "RecipeCell"

    @IBOutlet weak var recipeImage: UIImageView! {
        didSet {
            recipeImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var ingredients: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupImageAndText(recipe : Recipe) {
        label.text = recipe.label
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0

        let ingredientList = recipe.ingredients.count > 5 ? recipe.ingredients[0..<5] : recipe.ingredients[0..<recipe.ingredients.endIndex]
        ingredients.text = ingredientList.map { ingredient in
            return ingredient.food
        }.joined(separator: ", ")
        ingredients.textColor = .white
        ingredients.font = UIFont.preferredFont(forTextStyle: .headline)
        ingredients.numberOfLines = 0

        recipeImage.load(url: URL(string: recipe.image)!)
    }

    func setupImageAndText(recipe : RecipeCoreData) {
        label.text = recipe.label
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0

        if let ingredientsArray = recipe.ingredients {
            let ingredientList = ingredientsArray.count > 5 ? ingredientsArray[0..<5] : ingredientsArray[0..<ingredientsArray.endIndex]
            ingredients.text = ingredientList.map { ingredient in
                return ingredient
            }.joined(separator: ", ")
        }
        ingredients.textColor = .white
        ingredients.font = UIFont.preferredFont(forTextStyle: .headline)
        ingredients.numberOfLines = 0

        if let image = recipe.imageUrl {
            recipeImage.load(url: URL(string: image)!)

        }
    }
}
