//
//  SearchVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class SearchVC: UIViewController {
    let headerView = UIView()
    let questionLabel = RPTitleLabel(textAlignment: .center, fontSize: 32)
    let ingredientsTextField = RPTextField()
    let addButton = RPButton(backgroundColor: .systemGreen, title: "Add", font: .title3)
    let ingredientsLabel = RPTitleLabel(textAlignment: .left, fontSize: 24)
    let clearButton = RPButton(backgroundColor: .systemGray3, title: "Clear", font: .title3)
    let ingredientsTableView = UITableView()
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Search for recipes", font: .title1)

    var ingredients: [String] = []

    let padding: CGFloat = 30
    let internalPadding: CGFloat = 20
    let height: CGFloat = 40

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reciplease"
        view.backgroundColor = .secondarySystemBackground

        configureHeaderView()
        configureBodyView()
        createDismissKeyboardTapGesture()
    }

    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc private func addIngredientToIngredientsTableView() {
        guard ingredientsTextField.text != "" else { return }

        if let ingredient = ingredientsTextField.text {
            ingredients.append(ingredient)
            ingredientsTableView.reloadData()
            ingredientsTextField.text = nil
            ingredientsTextField.placeholder = nil
        }
    }

    @objc private func clearIngredientsTableView() {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
    }

    @objc private func pushRecipeListVC() {
        let recipeListVC = RecipeListVC()
        let ingredientsList = ingredients.joined(separator: ",")
        recipeListVC.ingredientsList = ingredientsList

        navigationController?.pushViewController(recipeListVC, animated: true)
    }

    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .tertiarySystemBackground

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 165)
        ])

        configureHeaderViewContent()
    }

    private func configureHeaderViewContent() {
        headerView.addSubview(questionLabel)
        questionLabel.text = "What's in your fridge?"

        headerView.addSubview(ingredientsTextField)
        headerView.addSubview(addButton)

        addButton.addTarget(self, action: #selector(addIngredientToIngredientsTableView), for: .touchUpInside)

        ingredientsTextField.delegate = self

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: height),

            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -internalPadding),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: height),

            ingredientsTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            ingredientsTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: internalPadding),
            ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    private func configureBodyView() {
        view.addSubview(ingredientsLabel)
        ingredientsLabel.text = "Your ingredients:"

        view.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearIngredientsTableView), for: .touchUpInside)

        view.addSubview(ingredientsTableView)
        ingredientsTableView.frame = view.bounds
        ingredientsTableView.layer.cornerRadius = 20
        ingredientsTableView.rowHeight = 50
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseID)
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(callToActionButton)

        callToActionButton.addTarget(self, action: #selector(pushRecipeListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 600),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: height),

            clearButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            clearButton.widthAnchor.constraint(equalToConstant: 70),
            clearButton.heightAnchor.constraint(equalToConstant: height),

            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            callToActionButton.heightAnchor.constraint(equalToConstant: 60),

            ingredientsTableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: padding),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2*padding),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2*padding),
            ingredientsTableView.bottomAnchor.constraint(equalTo: callToActionButton.topAnchor, constant: -30)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientsTextField.endEditing(true)
        addIngredientToIngredientsTableView()
        return true
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseID) as! IngredientCell
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}
