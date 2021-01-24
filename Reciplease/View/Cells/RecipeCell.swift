//
//  RecipeCell.swift
//  Reciplease
//
//  Created by anthonymfscott on 18/11/2020.
//

import UIKit

class RecipeCell: UITableViewCell {
    static let reuseID = "RecipeCell"

    let recipeImageView = RPRecipeImageView(frame: .zero)
    let recipeLabel = RPTitleLabel(textAlignment: .left, fontSize: 28)
    let ingredientsLabel = RPTitleLabel(textAlignment: .left, fontSize: 16)
    let detailLabel = RPBodyLabel(textAlignment: .right)

    let totalTimes = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(recipe: Recipe) {
        recipeLabel.text = recipe.label
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")

        NetworkManager.shared.downloadImage(from: recipe.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.recipeImageView.image = image }
        }
    }

    private func configure() {
        addSubviews(recipeImageView, recipeLabel, ingredientsLabel, detailLabel)

        recipeLabel.textColor = .white
        recipeLabel.shadowColor = .black
        recipeLabel.shadowOffset = CGSize(width: 1.6, height: 1.6)

        ingredientsLabel.textColor = .white
        ingredientsLabel.shadowColor = .black
        ingredientsLabel.shadowOffset = CGSize(width: 1, height: 1)

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.backgroundColor = .black
        detailLabel.textColor = .white
        detailLabel.text = """
            \(Int.random(in: 0...999)) 🤍
            \(totalTimes[Int.random(in: 0..<totalTimes.count)])' ⏱
            """

        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 20),

            recipeLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            recipeLabel.trailingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor),
            recipeLabel.heightAnchor.constraint(equalToConstant: 32),

            detailLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            detailLabel.heightAnchor.constraint(equalToConstant: 52),
            detailLabel.widthAnchor.constraint(equalToConstant: 68)
        ])
    }
}
