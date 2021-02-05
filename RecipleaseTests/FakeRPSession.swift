//
//  FakeRPSession.swift
//  RecipleaseTests
//
//  Created by anthonymfscott on 01/02/2021.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeAFRequest {
    var request: URLRequest? = nil
    var response: HTTPURLResponse? = nil
    var data: Data?
    var result: AFResult<Data>
}

class FakeRPSession: AlamoSession {
    private let fakeAFRequest: FakeAFRequest

    init(fakeAFRequest: FakeAFRequest) {
        self.fakeAFRequest = fakeAFRequest
    }

    func request(with url: URL, callback: @escaping (AFDataResponse<Data>) -> Void) {
        let fakeAFDataResponse = AFDataResponse(request: fakeAFRequest.request, response: fakeAFRequest.response, data: fakeAFRequest.data, metrics: nil, serializationDuration: 0, result: fakeAFRequest.result)
        callback(fakeAFDataResponse)
    }
}
