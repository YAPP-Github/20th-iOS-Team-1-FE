//
//  StubKeychainQueryRequester.swift
//  AppTests
//
//  Created by Hani on 2022/06/06.
//

import Foundation

@testable import App

final class StubKeychainQueryRequester: KeychainQueryRequestable {
    var createStatus = OSStatus()
    var readStatus = OSStatus()
    var updateStatus = OSStatus()
    var deleteStatus = OSStatus()
    var item: AnyObject?
    
    func create(_ query: CFDictionary) -> OSStatus {
        return createStatus
    }
    
    func read(_ query: CFDictionary) -> (item: AnyObject?, status: OSStatus) {
        return (item: item, status: readStatus)
    }
    
    func update(_ query: CFDictionary, with attributes: CFDictionary) -> OSStatus {
        return updateStatus
    }
    
    func delete(_ query: CFDictionary) -> OSStatus {
        return deleteStatus
    }
}
