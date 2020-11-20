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
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getRecipes(for ingredients: String, page: Int, completed: @escaping (Result<[Recipe], RPError>) -> Void) {
        let firstElement = page*10 - 10
        let lastElement = page*10

        let endpoint = baseUrl + "&q=\(ingredients)&from=\(firstElement)&to=\(lastElement)"

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
                let recipes = recipeResponse.hits
                completed(.success(recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        })

        task.resume()
    }

    func downloadImage(from urlString: String?, completed: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else { return }

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
