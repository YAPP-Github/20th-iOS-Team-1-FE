//
//  ExceptionDetailResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct ExceptionDetailResponseDTO: Codable {
    internal let field: String
    internal let value: String
    internal let reason: String
    
    enum CodingKeys: String, CodingKey {
        case field
        case value
        case reason
    }
}
