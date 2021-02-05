//
//  Recipe.swift
//  Reciplease
//
//  Created by anthonymfscott on 16/11/2020.
//

import Foundation

struct RecipeResponse: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: APIRecipe
}

struct APIRecipe: Codable {
    var image: String?
    var label: String
    var ingredientLines: [String]
    var url: String
}


extension APIRecipe: Recipe {
    func getImage() -> String? {
        if let image = image { return image }
        return nil
    }
    
    func getName() -> String {
        return label
    }

    func getIngredients() -> [String] {
        return ingredientLines
    }

    func getUrl() -> String {
        return url
    }
}
