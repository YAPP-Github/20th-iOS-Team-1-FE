//
//  FileManagerUseCase.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

final class FileManagerUseCase: FileManagerUseCaseInterface {
    private let fileManager: FileManageable
    
    init(fileManager: FileManageable) {
        self.fileManager = fileManager
    }
    
    func saveDataAtTemporaryPathAndReturnPath(_ data: Data, fileExtension: FileExtension) -> String? {
        let fileName = UUID().uuidString
        let temporaryDirectory = fileManager.temporaryDirectory
        let temporaryFilePath = temporaryDirectory.appendingPathComponent(fileName).appendingPathExtension(fileExtension.rawValue).path
        
//        if !fileManager.fileExists(atPath: temporaryFilePath),
//           fileManager.createFile(atPath: fileName, contents: data) {
//            return temporaryFilePath
//        }
        
        return nil
    }
}
