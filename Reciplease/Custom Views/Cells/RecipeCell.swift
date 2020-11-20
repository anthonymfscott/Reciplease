//
//  RecipeCell.swift
//  Reciplease
//
//  Created by anthonymfscott on 18/11/2020.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    static let reuseID = "RecipeCell"
    let recipeImageView = RPRecipeImageView(frame: .zero)
    let recipeLabel = RPTitleLabel(textAlignment: .left, fontSize: 24)
    let ingredientsLabel = RPTitleLabel(textAlignment: .left, fontSize: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(recipe: Recipe) {
        recipeLabel.text = recipe.recipe.label
        ingredientsLabel.text = recipe.recipe.ingredientLines.joined(separator: ", ")

        NetworkManager.shared.downloadImage(from: recipe.recipe.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.recipeImageView.image = image }
        }
    }

    private func configure() {
        addSubview(recipeImageView)
        addSubview(recipeLabel)
        recipeLabel.textColor = .white
        recipeLabel.shadowColor = .black
        recipeLabel.shadowOffset = CGSize(width: 1.6, height: 1.6)
        addSubview(ingredientsLabel)
        ingredientsLabel.textColor = .white
        ingredientsLabel.shadowColor = .black
        ingredientsLabel.shadowOffset = CGSize(width: 1, height: 1)

        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 16),

            recipeLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeLabel.trailingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor),
            recipeLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
