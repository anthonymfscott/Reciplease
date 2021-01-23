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
    let recipe: Recipe
}

struct Recipe: Codable {
    let image: String?
    let label: String
    let ingredientLines: [String]
    let url: String
}
