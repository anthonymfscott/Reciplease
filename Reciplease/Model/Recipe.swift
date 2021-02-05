//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by anthonymfscott on 28/01/2021.
//

import Foundation

protocol Recipe {
    func getImage() -> String?
    func getName() -> String
    func getIngredients() -> [String]
    func getUrl() -> String
}
