//
//  NetworkManager.swift
//  Reciplease
//
//  Created by anthonymfscott on 17/11/2020.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.edamam.com/search?app_id=96a4d08a&app_key=ebb19acb80a975dba752f611e2e88b37"

    private init() {}

    func getRecipes(for ingredients: String, completed: @escaping (Result<[Recipe], RPError>) -> Void) {
        let endpoint = baseUrl + "&q=\(ingredients)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)

                var recipes: [Recipe] = []
                for recipe in recipeResponse.hits {
                    recipes.append(recipe.recipe)
                }

                completed(.success(recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        })

        task.resume()
    }

    func downloadImage(from urlString: String?, completed: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else { return }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            completed(image)
        }

        task.resume()
    }
}
