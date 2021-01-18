//
//  RPRecipeImageView.swift
//  Reciplease
//
//  Created by anthonymfscott on 18/11/2020.
//

import UIKit

class RPRecipeImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
