//
//  RecipeListVC.swift
//  Reciplease
//
//  Created by anthonymfscott on 21/10/2020.
//

import UIKit

class RecipeListVC: RPDataLoadingVC {
    enum Section { case main }

    var ingredientsList: String!
    var recipes: [Recipe] = []
    var page = 1
    var containsMoreRecipes = true
    var isLoadingMoreRecipes = false

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getRecipes(ingredientsList: ingredientsList, page: page)
        configureDataSource()
    }

    init(ingredientsList: String) {
        super.init(nibName: nil, bundle: nil)

        self.ingredientsList = ingredientsList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRecipes(ingredientsList: String, page: Int) {
        showLoadingView()
        isLoadingMoreRecipes = true

        NetworkManager.shared.getRecipes(for: ingredientsList, page: page) { [weak self] result in
            self?.dismissLoadingView()
            
            guard let self = self else { return }

            switch result {
            case .success(let recipes):
                if recipes.count < 10 { self.containsMoreRecipes = false }
                self.recipes.append(contentsOf: recipes)

                if self.recipes.isEmpty {
                    let message = "This search didn't bring any results. Please try again with other ingredients."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData()
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: "Something bad happened", message: error.rawValue, buttonTitle: "OK")
            }

            self.isLoadingMoreRecipes = false
        }
    }

    private func configureViewController() {
        title = "Reciplease"
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
        snapshot.appendItems(recipes)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension RecipeListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard containsMoreRecipes && !isLoadingMoreRecipes else { return }
            page += 1
            getRecipes(ingredientsList: ingredientsList, page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.item]
        let detailVC = DetailVC()
        detailVC.recipe = recipe
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
}
