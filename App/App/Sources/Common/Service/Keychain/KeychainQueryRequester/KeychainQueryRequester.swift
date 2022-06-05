//
//  KeychainQueryRequester.swift
//  App
//
//  Created by Hani on 2022/06/05.
//

import Foundation

final class KeychainQueryRequester: KeychainQueryRequestable {
    internal static let shared = KeychainQueryRequester()
    
    internal func create(_ query: CFDictionary) -> OSStatus {
        return SecItemAdd(query, nil)
    }
    
    internal func read(_ query: CFDictionary) -> (item: AnyObject?, status: OSStatus) {
        var item: AnyObject?
        let status = SecItemCopyMatching(query, &item)
        
        return (item: item, status: status)
    }
    
    internal func update(_ query: CFDictionary, with attributes: CFDictionary) -> OSStatus {
        return SecItemUpdate(query, attributes)
    }
    
    internal func delete(_ query: CFDictionary) -> OSStatus {
        return SecItemDelete(query)
    }
}
