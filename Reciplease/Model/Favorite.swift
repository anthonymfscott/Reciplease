//
//  Favorite.swift
//  Reciplease
//
//  Created by anthonymfscott on 18/01/2021.
//

import CoreData

class Favorite: NSManagedObject {
    static var all: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favorites
    }
}
