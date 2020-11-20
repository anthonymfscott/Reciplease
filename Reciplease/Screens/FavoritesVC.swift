//
//  FavoritesVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class FavoritesVC: RPDataLoadingVC {

    enum Section { case main }

    var favorites: [Recipe] = []

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveFavorites()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cooker Cake Demo", size: 44)!]

        configureCollectionView()
        configureDataSource()
    }


    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
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
        snapshot.appendItems(favorites)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }


    private func retrieveFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites?\nAdd one by tapping the upper-left corner + button whilst you browse one you like!", in: self.view)
                }
                self.favorites = favorites
                self.updateData()
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


extension FavoritesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = favorites[indexPath.item]
        let detailVC = DetailVC()
        detailVC.recipe = recipe
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
}
