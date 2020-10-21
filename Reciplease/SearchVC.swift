//
//  SearchVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class SearchVC: UIViewController {

    let headerView = UIView()
    let questionLabel = UILabel()
    let ingredientsTextField = RPTextField()
    let addButton = RPButton(backgroundColor: .systemGreen, title: "Add", font: .title3)
    let ingredientsLabel = UILabel()
    let clearButton = RPButton(backgroundColor: .systemGray3, title: "Clear", font: .title3)
    let ingredientsListLabel = UILabel()
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Search for recipes", font: .largeTitle)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reciplease"
        view.backgroundColor = .secondarySystemBackground

        configureHeaderView()
    }

    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .tertiarySystemBackground

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 165)
        ])

        configureHeaderViewContent()
    }

    private func configureHeaderViewContent() {
        headerView.addSubview(questionLabel)
        headerView.addSubview(ingredientsTextField)
        headerView.addSubview(addButton)

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "What's in your fridge?"
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)

        let padding: CGFloat = 30
        let internalPadding: CGFloat = 20

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: 40),

            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -internalPadding),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 40),

            ingredientsTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            ingredientsTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: internalPadding),
            ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
