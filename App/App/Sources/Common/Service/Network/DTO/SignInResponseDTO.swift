//
//  SignInResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct SignInResponseDTO: Codable {
    internal let accessToken: String
    internal let refreshToken: String
    internal let firstAccount: Bool
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case firstAccount
    }
}
