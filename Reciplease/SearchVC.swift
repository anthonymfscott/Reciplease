//
//  SearchVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class SearchVC: UIViewController {

    let headerView = UIView()
    let questionLabel = RPLabel(text: "What's in your fridge?", textStyle: .largeTitle, textAlignment: .center)
    let ingredientsTextField = RPTextField()
    let addButton = RPButton(backgroundColor: .systemGreen, title: "Add", font: .title3)
    let ingredientsLabel = RPLabel(text: "Your ingredients:", textStyle: .title1, textAlignment: .left)
    let clearButton = RPButton(backgroundColor: .systemGray3, title: "Clear", font: .title3)
    let ingredientsListLabel = RPLabel(text: "- Apple\n\n- Tomatoes\n\n- Curry\n\n- Chicken", textStyle: .title1, textAlignment: .left)
    let callToActionButton = RPButton(backgroundColor: .systemGreen, title: "Search for recipes", font: .title1)

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
        configureBodyView()
    }

    private func configureHeaderViewContent() {
        headerView.addSubview(questionLabel)
        headerView.addSubview(ingredientsTextField)
        headerView.addSubview(addButton)

        let padding: CGFloat = 30
        let internalPadding: CGFloat = 20
        let height: CGFloat = 40

        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            questionLabel.heightAnchor.constraint(equalToConstant: height),

            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -internalPadding),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: height),

            ingredientsTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -padding),
            ingredientsTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: internalPadding),
            ingredientsTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    private func configureBodyView() {
        view.addSubview(ingredientsLabel)
        view.addSubview(clearButton)
        view.addSubview(ingredientsListLabel)
        view.addSubview(callToActionButton)

        let padding: CGFloat = 20
        let height: CGFloat = 40

        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 600),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: height),

            clearButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            clearButton.widthAnchor.constraint(equalToConstant: 70),
            clearButton.heightAnchor.constraint(equalToConstant: height),

            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            callToActionButton.heightAnchor.constraint(equalToConstant: 60),

            ingredientsListLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: padding),
            ingredientsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2*padding),
            ingredientsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2*padding),
            ingredientsListLabel.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
