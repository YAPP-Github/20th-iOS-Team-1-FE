//
//  TokenResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct TokenResponseDTO: Codable {
    internal let accessToken: String
    internal let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
    
    func toDomain() -> KeychainTokens {
        let tokens = KeychainTokens(accessToken: accessToken, refreshToken: refreshToken)
        
        return tokens
    }
}
