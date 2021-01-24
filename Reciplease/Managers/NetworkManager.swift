//
//  NetworkManager.swift
//  Reciplease
//
//  Created by anthonymfscott on 17/11/2020.
//

import UIKit
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.edamam.com/search?app_id=96a4d08a&app_key=ebb19acb80a975dba752f611e2e88b37"

    private init() {}

    func getRecipes(for ingredients: String, page: Int, completed: @escaping (Result<[Recipe], RPError>) -> Void) {
        let firstElement = page*10 - 10
        let lastElement = page*10

        let endpoint = baseUrl + "&q=\(ingredients)&from=\(firstElement)&to=\(lastElement)"

        AF.request(endpoint).validate().responseData { response in
            guard let data = response.data else {
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
        }
    }

    func downloadImage(from urlString: String?, completed: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else { return }

        AF.request(urlString).validate().responseData { response in
            guard let data = response.data else {
                completed(nil)
                return
            }

            completed(UIImage(data: data))
        }
    }
}
