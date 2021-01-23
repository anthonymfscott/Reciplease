//
//  RecipeListVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RecipeListVC: UIViewController {
    var ingredientsList: String!
    var recipes: [Recipe] = []

    var recipeTableView = UITableView()

    let messageLabel = RPTitleLabel(textAlignment: .center, fontSize: 24)
    let activityIndicator = UIActivityIndicatorView(style: .large)


    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.isHidden = false

        title = "Results"
        if let font = UIFont(name: Fonts.custom, size: 28) {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }

        configureUI()
        getRecipes(ingredientsList: ingredientsList)
    }

    init(ingredientsList: String) {
        super.init(nibName: nil, bundle: nil)
        self.ingredientsList = ingredientsList
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: View Methods

    func getRecipes(ingredientsList: String) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        NetworkManager.shared.getRecipes(for: ingredientsList) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }

            switch result {
            case .success(let recipes):
                self.recipes.append(contentsOf: recipes)

                if self.recipes.isEmpty {
                    DispatchQueue.main.async { self.messageLabel.isHidden = false }
                    return
                }

                DispatchQueue.main.async {
                    self.recipeTableView.isHidden = false
                    self.recipeTableView.reloadData()
                }
            case .failure(let error):
                let alertVC = UIAlertController(title: "Something bad happened", message: error.rawValue, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async { self.present(alertVC, animated: true) }
            }
        }
    }


    //MARK: UI Configuration

    func configureUI() {
        view.addSubviews(messageLabel, activityIndicator, recipeTableView)

        messageLabel.text = "This search didn't bring any results. Please try again with other ingredients."
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        messageLabel.isHidden = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.backgroundColor = .systemBackground
        recipeTableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.isHidden = true

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 300),

            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]

        let detailVC = DetailVC()
        detailVC.recipe = recipe

        let detailNC = UINavigationController(rootViewController: detailVC)
        present(detailNC, animated: true)
    }
}
