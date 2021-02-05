//
//  RPSession.swift
//  Reciplease
//
//  Created by anthonymfscott on 01/02/2021.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callback: @escaping (AFDataResponse<Data>) -> Void)
}

class RPSession: AlamoSession {
    func request(with url: URL, callback: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(url).validate().responseData { dataResponse in
            callback(dataResponse)
        }
    }
}
