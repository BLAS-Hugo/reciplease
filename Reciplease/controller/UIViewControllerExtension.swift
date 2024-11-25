//
//  UIViewControllerExtension.swift
//  Reciplease
//
//  Created by Hugo Blas on 03/10/2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert() {
        let alertController = UIAlertController(title: "An error occured", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

        present(alertController, animated: true)
    }

    func showAlreadyPresentAlert() {
        let alertController = UIAlertController(title: "Ingredient already present", message: "Please add another ingredient", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

        present(alertController, animated: true)
    }
}
