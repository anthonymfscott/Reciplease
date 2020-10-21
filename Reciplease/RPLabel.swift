//
//  RPTitleLabel.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RPLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(text: String, textStyle: UIFont.TextStyle, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
        self.textAlignment = textAlignment
        configure()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        textColor = .label
        numberOfLines = 0
    }
}
