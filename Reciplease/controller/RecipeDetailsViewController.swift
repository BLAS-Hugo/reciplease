//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Hugo Blas on 24/10/2024.
//

import Foundation
import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController {
    let recipe: Recipe

    var isLiked = false
    let viewModel = RecipeDetailsViewModel(dataProvider: RecipeDataProvider())

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!

    @IBOutlet weak var ingredientsView: UITextView!

    init?(coder: NSCoder, recipe: Recipe) {
        self.recipe = recipe
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        titleLabel.text = recipe.label
        titleLabel.numberOfLines = 2
        imageView.load(url: URL(string: recipe.image)!)
        cookingTimeLabel.text = String(recipe.totalTime / 60) + "h"
        for ingredient in recipe.ingredients {
            ingredientsView.text += "\n- \(ingredient.text)"
        }
    }

    @IBAction func onFavoriteButtonPressed() {
        isLiked.toggle()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if isLiked {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.addRecipeToFavorites(recipe: recipe)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.removeRecipeFromFavorites(recipe: recipe)
        }
    }

    @IBAction func onDirectionsButtonTapped() {
        let webViewController = WebViewController(url: recipe.url)
        let navigationController = UINavigationController(rootViewController: webViewController)
        present(navigationController, animated: true)
    }
}
