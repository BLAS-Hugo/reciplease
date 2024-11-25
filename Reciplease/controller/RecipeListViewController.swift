//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Hugo Blas on 26/09/2024.
//

import Foundation
import UIKit
import CoreData

class RecipeListViewController: UIViewController {
    var recipeList: RecipeResponse
    static var cellIdentifier = "RecipeCell"
    static var headerIdentifier = "recipeSectionHeader"

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: "RecipeCell", bundle: nil),
                forCellReuseIdentifier: RecipeListViewController.cellIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    init?(coder: NSCoder, recipeList: RecipeResponse) {
        self.recipeList = recipeList
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.rowHeight = 200
    }


    func openDetailsPage(recipe: Recipe) {
        let viewController = UIStoryboard.main.instantiateViewController(
            identifier: String(describing: RecipeDetailsViewController.self)
        ) { creator in
            let viewController = RecipeDetailsViewController(
    coder: creator, recipe: recipe)
            return viewController
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailsPage(recipe: recipeList.hits[indexPath.row].recipe)
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return recipeList.hits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell: RecipeCell =
            tableView.dequeueReusableCell(
                withIdentifier: RecipeListViewController.cellIdentifier,
                for: indexPath) as! RecipeCell

        let recipe = recipeList.hits[indexPath.row].recipe
        cell.setupImageAndText(recipe: recipe)

        return cell
    }
}
