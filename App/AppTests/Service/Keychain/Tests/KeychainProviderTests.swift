//
//  KeychainProviderTests.swift
//  AppTests
//
//  Created by Hani on 2022/06/06.
//

import XCTest

@testable import App

final class KeychainProviderTests: XCTestCase {
    private var sut: KeychainProvider!
    private var keychainQueryRequester: StubKeychainQueryRequester!
    
    override func setUpWithError() throws {
        keychainQueryRequester = StubKeychainQueryRequester()
    }

    override func tearDownWithError() throws {
        sut = nil
        keychainQueryRequester = nil
    }

    func test_키체인데이터생성하기_핸들링하지않은Status에러발생해서_실패() throws {
        // Given
        let status = Dummy.unknownErrorStatus
        keychainQueryRequester.createStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When
        XCTAssertThrowsError(try sut.create(Dummy.data, service: Dummy.service, account: Dummy.account)) { error in
            
            // Then
            XCTAssertEqual(error as? KeychainError, KeychainError.unhandledError(status: status))
        }
    }
    
    func test_키체인데이터생성하기_성공() throws {
        // Given
        let status = noErr
        keychainQueryRequester.createStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When, Then
        XCTAssertNoThrow(try sut.create(Dummy.data, service: Dummy.service, account: Dummy.account))
    }

    func test_키체인데이터불러오기_errSecItemNotFoundStatus에러발생해서_실패() throws {
        // Given
        let status = errSecItemNotFound
        keychainQueryRequester.readStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When
        XCTAssertThrowsError(try sut.read(service: Dummy.service, account: Dummy.account)) { error in
            
            // Then
            XCTAssertEqual(error as? KeychainError, KeychainError.noItemFound)
        }
    }
    
    func test_키체인데이터불러오기_핸들링하지않은Status에러발생해서_실패() throws {
        // Given
        let status = Dummy.unknownErrorStatus
        keychainQueryRequester.readStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When
        XCTAssertThrowsError(try sut.read(service: Dummy.service, account: Dummy.account)) { error in
            
            // Then
            XCTAssertEqual(error as? KeychainError, KeychainError.unhandledError(status: status))
        }
    }
    
    func test_키체인데이터불러오기_성공() throws {
        // Given
        let status = noErr
        keychainQueryRequester.item = Dummy.object
        keychainQueryRequester.readStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When, Then
        XCTAssertNoThrow(try sut.read(service: Dummy.service, account: Dummy.account))
    }
    
    func test_키체인데이터갱신하기_핸들링하지않은Status에러발생해서_실패() throws {
        // Given
        let status = Dummy.unknownErrorStatus
        keychainQueryRequester.updateStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When
        XCTAssertThrowsError(try sut.update(Dummy.data, service: Dummy.service, account: Dummy.account)) { error in
            
            // Then
            XCTAssertEqual(error as? KeychainError, KeychainError.unhandledError(status: status))
        }
    }
    
    func test_키체인데이터갱신하기_성공() throws {
        // Given
        let status = noErr
        keychainQueryRequester.updateStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When, Then
        XCTAssertNoThrow(try sut.update(Dummy.data, service: Dummy.service, account: Dummy.account))
    }
    
    func test_키체인데이터삭제하기_핸들링하지않은Status에러발생해서_실패() throws {
        // Given
        let status = Dummy.unknownErrorStatus
        keychainQueryRequester.deleteStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When
        XCTAssertThrowsError(try sut.delete(service: Dummy.service, account: Dummy.account)) { error in
            
            // Then
            XCTAssertEqual(error as? KeychainError, KeychainError.unhandledError(status: status))
        }
    }
    
    func test_키체인데이터삭제하기_성공() throws {
        // Given
        let status = noErr
        keychainQueryRequester.deleteStatus = status
        sut = KeychainProvider(keyChain: keychainQueryRequester)
        
        // When, Then
        XCTAssertNoThrow(try sut.delete(service: Dummy.service, account: Dummy.account))
    }
}

private enum Dummy {
    static let service = "service"
    static let account = "account"
    static let data = Data()
    static let object = Data() as AnyObject
    static let unknownErrorStatus: OSStatus = INT_MAX
}
