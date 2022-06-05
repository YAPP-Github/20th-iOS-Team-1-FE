//
//  KeychainQueryRequestable.swift
//  App
//
//  Created by Hani on 2022/06/05.
//

import Foundation

protocol KeychainQueryRequestable {
    func create(_ query: CFDictionary) -> OSStatus
    func read(_ query: CFDictionary) -> (item: AnyObject?, status: OSStatus)
    func update(_ query: CFDictionary, with attributes: CFDictionary) -> OSStatus
    func delete(_ query: CFDictionary) -> OSStatus
}
