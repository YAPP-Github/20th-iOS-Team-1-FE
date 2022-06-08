//
//  ExceptionResponseInfoDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct ExceptionResponseInfoDTO: Codable {
    internal let status: String
    internal let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
}
