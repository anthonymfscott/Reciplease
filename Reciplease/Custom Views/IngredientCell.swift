//
//  IngredientCell.swift
//  Reciplease
//
//  Created by anthonymfscott on 16/11/2020.
//

import UIKit

class IngredientCell: UITableViewCell {
    static let reuseID = "IngredientCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
