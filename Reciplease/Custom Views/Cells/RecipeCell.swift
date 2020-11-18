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
        if let url = recipe.recipe.image { recipeImageView.downloadImage(from: url) }
        recipeLabel.text = recipe.recipe.label
        ingredientsLabel.text = recipe.recipe.ingredientLines.joined(separator: ", ")
    }

    private func configure() {
        addSubview(recipeImageView)
        addSubview(recipeLabel)
        recipeLabel.textColor = .white
        recipeLabel.shadowColor = .black
        recipeLabel.shadowOffset = CGSize(width: 1.4, height: 1.4)
        addSubview(ingredientsLabel)
        ingredientsLabel.textColor = .white
        ingredientsLabel.shadowColor = .black
        ingredientsLabel.shadowOffset = CGSize(width: 0.8, height: 0.8)

        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
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
