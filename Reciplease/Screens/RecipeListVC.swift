//
//  RecipeListVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RecipeListVC: UIViewController {
    var ingredientsList: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reciplease"
        view.backgroundColor = .systemRed

        NetworkManager.shared.getRecipes(for: ingredientsList) { (recipes, errorMessage) in
            guard let recipes = recipes else {
                self.presentRPAlertOnMainThread(title: "Something bad happened", message: errorMessage!, buttonTitle: "OK")
                return
            }

            print("Recipes.count: \(recipes.count)")
        }
    }
}
