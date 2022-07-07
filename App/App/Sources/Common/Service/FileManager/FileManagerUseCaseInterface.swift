//
//  FileManagerUseCaseInterface.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

protocol FileManagerUseCaseInterface {
    func saveDataAtTemporaryPathAndReturnPath(_ data: Data, fileExtension: FileExtension) -> String?
}
