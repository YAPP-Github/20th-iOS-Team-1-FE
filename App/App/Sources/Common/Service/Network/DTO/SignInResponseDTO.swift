//
//  SignInResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct SignInResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case firstAccount
    }
    
    internal let accessToken: String
    internal let refreshToken: String
    internal let firstAccount: Bool
    
    internal func toDomain() -> SignInResult {
        let signInResult = SignInResult(accessToken: accessToken, refreshToken: refreshToken, firstAccount: firstAccount)
        
        return signInResult
    }
}
