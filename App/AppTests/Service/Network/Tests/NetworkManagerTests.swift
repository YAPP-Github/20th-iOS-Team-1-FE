//
//  NetworkManagerTests.swift
//  AppTests
//
//  Created by Hani on 2022/06/08.
//

import XCTest

import RxBlocking
import RxTest

@testable import App

final class NetworkManagerTests: XCTestCase {
    private var sut: NetworkManager!
    private var urlSession: URLSession!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        sut = NetworkManager(session: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.requestHandler = nil
        urlSession = nil
    }

    func test_DataTask요청했으나_Transport에러때문에_실패() throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            throw NetworkError.transportError(DummyError())
        }
        
        // When
        XCTAssertThrowsError(try sut.requestDataTask(with: Dummy.urlRequest).toBlocking(timeout: 0.5).single()) { error in
            
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.transportError(DummyError()))
        }
    }
    
    func test_DataTask요청했으나_Server에러때문에_실패() throws {
        // Given
        let ServerErrorStatusCode = 400
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: Dummy.url, statusCode: ServerErrorStatusCode, httpVersion: Dummy.httpVersion, headerFields: Dummy.headerFields)!
            return (response, nil)
        }
        
        // When
        XCTAssertThrowsError(try sut.requestDataTask(with: Dummy.urlRequest).toBlocking(timeout: 0.5).single()) { error in
            
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.serverError(statusCode: ServerErrorStatusCode))
        }
    }
    
    func test_DataTask요청_성공() throws {
        // Given
        let expected = Data()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: Dummy.url, statusCode: 200, httpVersion: Dummy.httpVersion, headerFields: Dummy.headerFields)!
            return (response, expected)
        }
        
        // When
        let result = try sut.requestDataTask(with: Dummy.urlRequest).toBlocking(timeout: 0.5).single()
        
        // Then
        XCTAssertEqual(result, expected)
    }
}

private enum Dummy {
    static let url = URL(string: "https://www.yapp.co.kr/")!
    static let urlRequest = URLRequest(url: url)
    static let statusCode = 200
    static let httpVersion = "2.0"
    static let headerFields: [String: String]? = nil
}

private struct DummyError: Error { }

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noDataError, .noDataError):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        case (.transportError(_), .transportError(_)):
            return true
        default:
            return false
        }
    }
}
