//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by anthonymfscott on 25/01/2021.
//

import Foundation

class FakeResponseData {
    let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    class RecipeError: Error {}
    let error = RecipeError()

    var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let recipeIncorrectData = "error".data(using: .utf8)!

    let imageData = "image".data(using: .utf8)!
}
