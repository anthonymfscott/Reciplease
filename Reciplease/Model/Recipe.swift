//
//  Recipe.swift
//  Reciplease
//
//  Created by anthonymfscott on 16/11/2020.
//

import Foundation

struct Recipe: Codable {
    let recipe: RecipeDetail
}

struct RecipeResponse: Codable {
    let hits: [Recipe]
}

struct RecipeDetail: Codable {
    let image: String?
    let label: String
    let ingredientLines: [String]
    let url: String
}
