//
//  RPTextField.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RPTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth = true

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .done
        clearButtonMode = .whileEditing
        placeholder = "Enter a new ingredient here"
    }
}
