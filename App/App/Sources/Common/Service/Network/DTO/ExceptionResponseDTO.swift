//
//  ExceptionResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct ExceptionResponseDTO: Codable {
    internal let message: String
    internal let status: String
    internal let errors: [ExceptionDetailResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
        case errors
    }
}
