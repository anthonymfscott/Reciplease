//
//  DetailVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 19/11/2020.
//

import UIKit
import SafariServices

class DetailVC: UIViewController {
    var recipe: Recipe!

    let recipeImageView = RPRecipeImageView(frame: .zero)
    let recipeLabel = RPTitleLabel(textAlignment: .center, fontSize: 32)
    let ingredientsTitleLabel = RPTitleLabel(textAlignment: .left, fontSize: 24)
    let ingredientsScrollView = UIScrollView()
    let ingredientsListLabel = RPBodyLabel(textAlignment: .left)
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Get directions", font: .title1)


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem = doneButton

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton

        configure()
        configureCallToActionButton()
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    @objc private func addButtonTapped() {
        // Favorites functionality
    }

    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
        callToActionButton.titleLabel?.font = UIFont(name: Fonts.custom, size: 44)
    }

    @objc private func callToActionButtonTapped() {
        guard let url = URL(string: recipe.recipe.url) else {
            let alertVC = UIAlertController(title: "Invalid URL", message: "The url attached to this recipe is invalid.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertVC, animated: true)
            return
        }

        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }


    //MARK: UI Configuration

    private func configure() {
        view.addSubviews(recipeImageView, recipeLabel, ingredientsTitleLabel, ingredientsScrollView, callToActionButton)

        NetworkManager.shared.downloadImage(from: recipe.recipe.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.recipeImageView.image = image }
        }

        recipeLabel.text = recipe.recipe.label
        recipeLabel.textColor = .white
        recipeLabel.shadowColor = .black
        recipeLabel.shadowOffset = CGSize(width: 1.8, height: 1.8)

        ingredientsTitleLabel.text = "Ingredients:"

        ingredientsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsScrollView.addSubview(ingredientsListLabel)

        ingredientsListLabel.text = "- " + recipe.recipe.ingredientLines.joined(separator: "\n- ")
        ingredientsListLabel.pinToEdges(of: ingredientsScrollView)

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

            ingredientsScrollView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 10),
            ingredientsScrollView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: padding),
            ingredientsScrollView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -padding),
            ingredientsScrollView.bottomAnchor.constraint(equalTo: callToActionButton.topAnchor, constant: -padding),
        ])
    }
}
