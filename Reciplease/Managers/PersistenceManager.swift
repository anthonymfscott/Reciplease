//
//  PersistenceManager.swift
//  Reciplease
//
//  Created by anthonymfscott on 28/01/2021.
//

import Foundation
import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    private init() {}

    let storage = CoreDataStore(.persistent)

    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favorites
    }


    func save(_ recipe: Recipe) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.label = recipe.getName()
        favoriteRecipe.ingredientLines = recipe.getIngredients().joined(separator: ", ")
        favoriteRecipe.image = recipe.getImage()
        favoriteRecipe.url = recipe.getUrl()

        try? AppDelegate.viewContext.save()
    }

    func delete(_ recipe: Recipe) {
        AppDelegate.viewContext.delete(recipe as! NSManagedObject)
        try? AppDelegate.viewContext.save()
    }
}
