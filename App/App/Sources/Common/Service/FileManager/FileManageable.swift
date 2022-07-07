//
//  FileManageable.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

protocol FileManageable {
    var temporaryDirectory: URL { get }
    
    func contents(atPath path: String) -> Data?
    //func createFile(atPath path: String, contents data: Data?) -> Bool
    func fileExists(atPath path: String) -> Bool
    func removeItem(atPath path: String) throws
}
