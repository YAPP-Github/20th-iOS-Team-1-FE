//
//  FileManagerProxy.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

final class FileManagerProxy: FileManageable {
    private let manager: FileManageable = FileManager.default
    
    var temporaryDirectory: URL {
        manager.temporaryDirectory
    }
    
    func contents(atPath path: String) -> Data? {
        manager.contents(atPath: path)
    }
    
//    func createFile(atPath path: String, contents data: Data?) -> Bool {
//        manager.createFile(atPath: path, contents: data)
//    }
    
    func fileExists(atPath path: String) -> Bool {
        manager.fileExists(atPath: path)
    }
    
    func removeItem(atPath path: String) throws {
        try manager.removeItem(atPath: path)
    }
}
