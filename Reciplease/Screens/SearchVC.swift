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
    let addButton = RPButton(backgroundColor: .black, title: "Add", font: .title3)
    let forkImage = UIImageView(image: UIImage(named: "RPFork"))

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
        view.backgroundColor = .secondarySystemBackground

        configureHeaderView()
        configureBodyView()
        createDismissKeyboardTapGesture()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ingredientsTextField.text = ""
        navigationController?.navigationBar.isHidden = true
    }


    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
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
        let ingredientsList = ingredients.joined(separator: ",")
        let recipeListVC = RecipeListVC(ingredientsList: ingredientsList)

        navigationController?.pushViewController(recipeListVC, animated: true)
    }


    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemGreen

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280)
        ])

        headerView.addSubviews(forkImage, questionLabel, addButton, ingredientsTextField)
        configureForkImage()
        configureQuestionLabel()
        configureAddButton()
        configureIngredientsTextField()
    }


    private func configureForkImage() {
        forkImage.translatesAutoresizingMaskIntoConstraints = false
        forkImage.clipsToBounds = true
        forkImage.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            forkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            forkImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            forkImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            forkImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }


    private func configureQuestionLabel() {
        questionLabel.text = "What's in your fridge?"
        questionLabel.font = UIFont(name: "Cooker Cake Demo", size: 44)

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: forkImage.bottomAnchor, constant: internalPadding),
            questionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }


    private func configureAddButton() {
        addButton.addTarget(self, action: #selector(addIngredientToIngredientsTableView), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -padding),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: height)
        ])
    }


    private func configureIngredientsTextField() {
        ingredientsTextField.delegate = self

        NSLayoutConstraint.activate([
            ingredientsTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            ingredientsTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding),
            ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -internalPadding),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    
    private func configureBodyView() {
        view.addSubviews(ingredientsLabel, clearButton, ingredientsTableView, callToActionButton)

        ingredientsLabel.text = "Your ingredients:"

        clearButton.addTarget(self, action: #selector(clearIngredientsTableView), for: .touchUpInside)

        ingredientsTableView.frame = view.bounds
        ingredientsTableView.layer.cornerRadius = 20
        ingredientsTableView.rowHeight = 50
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseID)
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false

        callToActionButton.addTarget(self, action: #selector(pushRecipeListVC), for: .touchUpInside)
        callToActionButton.titleLabel?.font = UIFont(name: "Cooker Cake Demo", size: 44)

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
