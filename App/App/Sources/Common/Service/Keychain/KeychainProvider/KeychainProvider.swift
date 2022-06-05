//
//  KeychainProvider.swift
//  App
//
//  Created by Hani on 2022/06/05.
//

import Foundation

final class KeychainProvider: KeychainProvidable {
    internal static let shared = KeychainProvider()
    
    private let keychain: KeychainQueryRequestable
    
    init(keyChain: KeychainQueryRequestable = KeychainQueryRequester.shared) {
        self.keychain = keyChain
    }
    
    internal func create(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        let status = keychain.create(query)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicatedItem
        }
        
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
    }
        
    internal func read(service: String, account: String) throws -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
               
        let keyChainQueryResult = keychain.read(query)
        let item = keyChainQueryResult.item as? Data
        let status = keyChainQueryResult.status
        
        guard status != errSecItemNotFound else {
            throw KeychainError.noItemFound
        }
             
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }

        return item
    }
    
    internal func update(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        let attributes = [kSecValueData: data] as CFDictionary
        
        let status = keychain.update(query, with: attributes)

        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    internal func delete(service: String, account: String) throws {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
                
        let status = keychain.delete(query)
        
        guard status == noErr else {
            throw KeychainError.unhandledError(status: status)
        }
    }
}
