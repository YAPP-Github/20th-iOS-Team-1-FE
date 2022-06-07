//
//  MockURLProtocol.swift
//  AppTests
//
//  Created by Hani on 2022/06/07.
//

import Foundation
import XCTest

import RxSwift

final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() { }
    
    override func startLoading() {
        guard let requestHandler = MockURLProtocol.requestHandler else {
            XCTFail("MockURLProtocol`s requestHandler was not initialized")
            return
        }
        
        do {
            let (response, data) = try requestHandler(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
