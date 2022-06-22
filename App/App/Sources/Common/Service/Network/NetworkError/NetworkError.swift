//
//  NetworkError.swift
//  App
//
//  Created by Hani on 2022/06/06.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noDataError
    case decodeError
}
