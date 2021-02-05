//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit
import CoreData
import SafariServices

class FavoritesVC: UIViewController {
    var recipes: [Recipe] = []
    var recipeTableView = UITableView()
    let messageLabel = RPTitleLabel(textAlignment: .center, fontSize: 24)


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        title = "Favorites"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.custom, size: 28)!]

        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        recipes.removeAll()

        for favoriteRecipe in PersistenceManager.all { recipes.append(favoriteRecipe) }

        if recipes.isEmpty { return }

        messageLabel.isHidden = true

        recipeTableView.reloadData()
        recipeTableView.isHidden = false
    }

    private func configureUI() {
        view.addSubviews(recipeTableView, messageLabel)

        messageLabel.text = "No favorites yet?\n Tap the star in the top right corner while browsing a recipe to add it here!"
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        messageLabel.isHidden = false

        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.backgroundColor = .systemBackground
        recipeTableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.isHidden = true

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 300),

            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID) as! RecipeCell
        cell.set(recipe: recipes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let favorite = recipes[indexPath.row]
        PersistenceManager.shared.delete(favorite)
        
        recipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]

        let detailVC = DetailVC()
        detailVC.recipe = recipe

        let detailNC = UINavigationController(rootViewController: detailVC)
        present(detailNC, animated: true)
    }
}
