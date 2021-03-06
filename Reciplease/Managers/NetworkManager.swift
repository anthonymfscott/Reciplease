//
//  NetworkManager.swift
//  Reciplease
//
//  Created by anthonymfscott on 17/11/2020.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.edamam.com/search?app_id=96a4d08a&app_key=ebb19acb80a975dba752f611e2e88b37"
    let cache = NSCache<NSString, UIImage>()

    private var recipeSession: AlamoSession = RPSession()
    private var imageSession: AlamoSession = RPSession()

    init(recipeSession: AlamoSession, imageSession: AlamoSession) {
        self.recipeSession = recipeSession
        self.imageSession = imageSession
    }
    
    private init() {}

    func getRecipes(for ingredients: String, page: Int, completed: @escaping (Result<[APIRecipe], RPError>) -> Void) {
        let firstElement = page*10 - 10
        let lastElement = page*10

        let endpoint = baseUrl + "&q=\(ingredients)&from=\(firstElement)&to=\(lastElement)"
        guard let url = URL(string: endpoint) else { return }

        recipeSession.request(with: url) { response in
            guard let data = response.data else {
                completed(.failure(.standard))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)

                var recipes: [APIRecipe] = []
                for recipe in recipeResponse.hits {
                    recipes.append(recipe.recipe)
                }

                completed(.success(recipes))
            } catch {
                completed(.failure(.standard))
            }
        }
    }

    func downloadImage(from urlString: String?, completed: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        imageSession.request(with: url) { response in
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
