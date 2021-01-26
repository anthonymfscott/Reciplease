//
//  AFSession.swift
//  Reciplease
//
//  Created by anthonymfscott on 26/01/2021.
//

import Foundation
import Alamofire

//protocol AFSession {
//    func request(with url: String, callback: @escaping (AFDataResponse<Data>) -> Void)
//}

class AFSession: Session {
    func request(with url: String, callback: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(url).validate().responseData { response in
            callback(response)
        }
    }
}
