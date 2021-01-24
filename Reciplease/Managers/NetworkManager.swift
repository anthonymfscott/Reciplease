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
    let cache = NSCache<NSString, UIImage>()
    
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

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        AF.request(urlString).validate().responseData { response in
            guard let data = response.data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
    }
}
