//
//  KeychainProvidable.swift
//  App
//
//  Created by Hani on 2022/06/05.
//

import Foundation

protocol KeychainProvidable: AnyObject {
    func create(_ data: Data, service: String, account: String) throws
    func read(service: String, account: String) throws -> Data?
    func update(_ data: Data, service: String, account: String) throws
    func delete(service: String, account: String) throws
}
