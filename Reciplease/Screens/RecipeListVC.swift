//
//  RecipeListVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RecipeListVC: UIViewController {
    enum Section { case main }

    var ingredientsList: String!
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    var recipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getRecipes()
        configureDataSource()
    }

    func getRecipes() {
        NetworkManager.shared.getRecipes(for: ingredientsList) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let recipes):
                self.recipes = recipes
                self.updateData()
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: "Something bad happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    private func configureViewController() {
        title = "Reciplease"
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseID)
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseID, for: indexPath) as! RecipeCell
            cell.set(recipe: recipe)
            return cell
        })
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipes)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
