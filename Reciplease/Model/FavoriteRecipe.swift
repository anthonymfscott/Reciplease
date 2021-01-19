//
//  FavoritedRecipe.swift
//  Reciplease
//
//  Created by anthonymfscott on 19/01/2021.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {
    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favorites
    }
}
