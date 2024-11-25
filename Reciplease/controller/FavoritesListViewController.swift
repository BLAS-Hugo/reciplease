//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Hugo Blas on 07/11/2024.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController {
    static var cellIdentifier = "RecipeCell"
    static var headerIdentifier = "favoriteSectionHeader"
    let viewModel = FavoritesListViewModel(dataProvider: RecipeDataProvider())

    var favorites: [RecipeCoreData] = []

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: "RecipeCell", bundle: nil),
                forCellReuseIdentifier: FavoritesListViewController.cellIdentifier)
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        getFavoritesRecipeList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoritesRecipeList()
    }

    func getFavoritesRecipeList() {
        favorites = viewModel.getRecipesInFavorite()
        print(favorites)
        tableView.reloadData()
    }
}

extension FavoritesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesListViewController.cellIdentifier, for: indexPath) as! RecipeCell

        let recipe = favorites[indexPath.row]

        cell.setupImageAndText(recipe: recipe)

        return cell
    }
}
