//
//  SearchVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class SearchVC: UIViewController {
    var ingredients: [String] = []

    let headerView = UIView()
    let forkImage = UIImageView(image: UIImage(named: Images.fork))
    let questionLabel = RPTitleLabel(textAlignment: .center, fontSize: 32)
    let ingredientsTextField = RPTextField()
    let addButton = RPButton(backgroundColor: .black, title: "Add", font: .title3)

    let ingredientsLabel = RPTitleLabel(textAlignment: .left, fontSize: 24)
    let clearButton = RPButton(backgroundColor: .systemGray3, title: "Clear", font: .title3)
    let ingredientsTableView = UITableView()
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Search for recipes", font: .title1)


    //MARK: View Life Cycle

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


    //MARK: View Methods

    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc private func addIngredientToIngredientsTableView() {
        guard ingredientsTextField.text != "", let ingredient = ingredientsTextField.text else { return }

        ingredients.append(ingredient)
        ingredientsTableView.reloadData()
        ingredientsTextField.text = ""
        ingredientsTextField.placeholder = ""
    }

    @objc private func clearIngredientsTableView() {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
    }

    @objc private func pushRecipeListVC() {
        let recipeListVC = RecipeListVC(ingredientsList: ingredients.joined(separator: ","))
        navigationController?.pushViewController(recipeListVC, animated: true)
    }


    //MARK: UI Configuration

    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemGreen

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 310)
        ])

        configureHeaderViewContent()
    }

    private func configureHeaderViewContent() {
        headerView.addSubviews(forkImage, questionLabel, addButton, ingredientsTextField)

        forkImage.translatesAutoresizingMaskIntoConstraints = false
        forkImage.clipsToBounds = true
        forkImage.contentMode = .scaleAspectFill

        questionLabel.text = "What's in your fridge?"
        questionLabel.font = UIFont(name: Fonts.custom, size: 44)

        addButton.addTarget(self, action: #selector(addIngredientToIngredientsTableView), for: .touchUpInside)

        ingredientsTextField.delegate = self

        let padding: CGFloat = 30
        let height: CGFloat = 40

        NSLayoutConstraint.activate([
            forkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            forkImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            forkImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            forkImage.heightAnchor.constraint(equalToConstant: 80),

            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -padding),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: height),

            ingredientsTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            ingredientsTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding),
            ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: height),

            questionLabel.bottomAnchor.constraint(equalTo: ingredientsTextField.topAnchor, constant: -16),
            questionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: height),
        ])
    }

    private func configureBodyView() {
        view.addSubviews(ingredientsLabel, clearButton, ingredientsTableView, callToActionButton)

        ingredientsLabel.text = "Your ingredients:"

        clearButton.addTarget(self, action: #selector(clearIngredientsTableView), for: .touchUpInside)

        ingredientsTableView.layer.cornerRadius = 20
        ingredientsTableView.rowHeight = 50
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseID)
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false

        callToActionButton.addTarget(self, action: #selector(pushRecipeListVC), for: .touchUpInside)
        callToActionButton.titleLabel?.font = UIFont(name: Fonts.custom, size: 44)

        let padding: CGFloat = 30
        let height: CGFloat = 40

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


//MARK: Protocol delegates

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
