//
//  KeychainError.swift
//  App
//
//  Created by Hani on 2022/06/05.
//

import Foundation

enum KeychainError: Error, Equatable {
    case noItemFound
    case duplicatedItem
    case unhandledError(status: OSStatus)
}
