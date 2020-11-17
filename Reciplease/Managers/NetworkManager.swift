//
//  NetworkManager.swift
//  Reciplease
//
//  Created by anthonymfscott on 17/11/2020.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.edamam.com/search?app_id=96a4d08a&app_key=ebb19acb80a975dba752f611e2e88b37"

    private init() {}

    func getRecipes(for ingredients: String, completed: @escaping ([Recipe]?, String?) -> Void) {
        let endpoint = baseUrl + "&q=\(ingredients)"

        guard let url = URL(string: endpoint) else {
            completed(nil, "These ingredients created an invalid request. Please try again.")
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }

            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                let recipes = recipeResponse.hits
                completed(recipes, nil)
            } catch {
                completed(nil, "The data received from the server was invalid (decoding). Please try again.")
            }
        })

        task.resume()
    }
}
