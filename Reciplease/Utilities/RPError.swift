//
//  RPError.swift
//  Reciplease
//
//  Created by anthonymfscott on 17/11/2020.
//

import Foundation

enum RPError: String, Error {
    case invalidRequest = "The request is invalid. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this recipe. Please try again."
    case alreadyInFavorites = "You've already favorited this recipe. You must REALLY like it!"
}
