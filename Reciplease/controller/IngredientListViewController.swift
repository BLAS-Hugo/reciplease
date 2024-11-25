//
//  IngredientListViewController.swift
//  Reciplease
//
//  Created by Hugo Blas on 19/09/2024.
//

import Foundation
import UIKit

class IngredientListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    static var cellIdentifier = "IngredientCell"
    static var headerIdentifier = "ingredientSectionHeader"

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    private let recipeRepository = RecipeRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        textField.keyboardType = UIKeyboardType.alphabet
        textField.clearsOnBeginEditing = true
        activityIndicator.isHidden = true
        searchButton.isHidden = false
    }

    @IBAction func onAddButtonTapped() {
        if !textField.hasText {
            return
        }
        if IngredientList.shared.ingredients.contains(textField.text ?? "") {
            showAlreadyPresentAlert()
        }
        IngredientList.shared.add(ingredient: textField.text ?? "")
        tableView.reloadData()
        textField.text = ""
    }

    @IBAction func onSearchButtonTapped() {
        Task {
            do {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
                searchButton.isHidden = true
                let recipeList = try await recipeRepository.getRecipeWithKeywords(IngredientList.shared.ingredients)
                let viewController = UIStoryboard.main.instantiateViewController(identifier: String(describing: RecipeListViewController.self)) { creator in
                    let viewController = RecipeListViewController(coder: creator, recipeList: recipeList)
                    return viewController
                }
                navigationController?.pushViewController(viewController, animated: true)
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
                searchButton.isHidden = false
            } catch {
                showErrorAlert()
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
                searchButton.isHidden = false
            }
        }
    }

    @IBAction func onClearButtonTapped() {
        IngredientList.shared.clear()
        tableView.reloadData()
    }
}

extension IngredientListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientList.shared.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientListViewController.cellIdentifier, for: indexPath)

        let ingredient = IngredientList.shared.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient

        return cell
    }
}
