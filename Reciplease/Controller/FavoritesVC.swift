//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        title = "Favorites"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.custom, size: 28)!]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        for favorite in Favorite.all {
            print(favorite.name!)
        }
    }
}
