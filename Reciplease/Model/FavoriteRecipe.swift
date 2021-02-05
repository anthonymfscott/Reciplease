//
//  FavoritedRecipe.swift
//  Reciplease
//
//  Created by anthonymfscott on 19/01/2021.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {}

extension FavoriteRecipe: Recipe {
    func getImage() -> String? {
        guard let image = image else { return nil }
        return image
    }

    func getName() -> String {
        return label!
    }

    func getIngredients() -> [String] {
        return ingredientLines!.components(separatedBy: ", ")
    }

    func getUrl() -> String {
        return url!
    }
}
