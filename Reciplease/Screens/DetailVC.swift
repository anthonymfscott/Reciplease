//
//  DetailVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 19/11/2020.
//

import UIKit

class DetailVC: UIViewController {
    var recipe: Recipe!

    let recipeImageView = RPRecipeImageView(frame: .zero)
    let recipeLabel = RPTitleLabel(textAlignment: .center, fontSize: 32)
    let ingredientsTitleLabel = RPTitleLabel(textAlignment: .left, fontSize: 24)
    let ingredientsListLabel = RPBodyLabel(textAlignment: .left)
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Get directions", font: .title1)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = addButton

        configure()
        configureCallToActionButton()
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
    }

    @objc private func callToActionButtonTapped() {
        guard let url = URL(string: recipe.recipe.url) else {
            presentRPAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "OK")
            return
        }

        presentSafariVC(with: url)
    }

    private func configure() {
        view.addSubview(recipeImageView)
        NetworkManager.shared.downloadImage(from: recipe.recipe.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.recipeImageView.image = image }
        }
        view.addSubview(recipeLabel)
        recipeLabel.text = recipe.recipe.label
        recipeLabel.textColor = .white
        recipeLabel.shadowColor = .black
        recipeLabel.shadowOffset = CGSize(width: 1.8, height: 1.8)
        view.addSubview(ingredientsTitleLabel)
        ingredientsTitleLabel.text = "Ingredients:"
        view.addSubview(ingredientsListLabel)
        ingredientsListLabel.text = "- " + recipe.recipe.ingredientLines.joined(separator: "\n- ")
        view.addSubview(callToActionButton)

        let padding: CGFloat = 16

        let imageHeight: CGFloat = view.bounds.height/2 - 100

        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            recipeLabel.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -padding),
            recipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: padding),
            recipeLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -padding),
            recipeLabel.heightAnchor.constraint(equalToConstant: 36),

            ingredientsTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: padding),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: padding),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -padding),
            ingredientsTitleLabel.heightAnchor.constraint(equalToConstant: 28),

            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            callToActionButton.heightAnchor.constraint(equalToConstant: 60),

            ingredientsListLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor),
            ingredientsListLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: padding),
            ingredientsListLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -padding),
            ingredientsListLabel.bottomAnchor.constraint(equalTo: callToActionButton.topAnchor, constant: -padding)
        ])
    }

    @objc private func addButtonTapped() {
        PersistenceManager.updateWith(favorite: recipe, actionType: .add) { [weak self] error in
            guard let self = self else { return }

            guard let error = error else {
                self.presentRPAlertOnMainThread(title: "Success!", message: "You have successfully favorited this recipe 😋", buttonTitle: "Yummy!")
                return
            }

            self.presentRPAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
}
