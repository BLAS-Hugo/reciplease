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
    private let recipeRepository = RecipeRepository(session: NetworkSession())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        textField.keyboardType = UIKeyboardType.alphabet
        textField.clearsOnBeginEditing = true
        activityIndicator.isHidden = true
        searchButton.isHidden = false
        textField.accessibilityLabel = "Ingredient text field"
    }

    @IBAction func onAddButtonTapped() {
        if !textField.hasText {
            return
        }
        if IngredientList.shared.contains(ingredient: textField.text ?? "") {
            showAlreadyPresentAlert()
            return
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
                let recipeList = try await recipeRepository.getRecipeWithKeywords(
                    IngredientList.shared.getAllIngredients())
                let viewController = UIStoryboard.main.instantiateViewController(
                    identifier: String(describing: RecipeListViewController.self)) { creator in
                    let viewController = RecipeListViewController(coder: creator, recipeList: recipeList)
                    return viewController
                }
                navigationController?.pushViewController(viewController, animated: true)
                stopAnimation()
            } catch {
                showErrorAlert()
                stopAnimation()
            }
        }
    }

    @IBAction func onClearButtonTapped() {
        IngredientList.shared.clear()
        tableView.reloadData()
    }

    private func stopAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        searchButton.isHidden = false
    }
}

extension IngredientListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientList.shared.getAllIngredients().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientListViewController.cellIdentifier, for: indexPath)

        let ingredient = IngredientList.shared.getAllIngredients()[indexPath.row]
        cell.textLabel?.text = ingredient
        cell.textLabel?.font = .preferredFont(forTextStyle: .body)
        cell.textLabel?.adjustsFontForContentSizeCategory = true

        return cell
    }
}
