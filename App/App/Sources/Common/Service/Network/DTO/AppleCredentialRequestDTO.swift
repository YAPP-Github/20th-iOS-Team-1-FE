//
//  AppleCredentialRequestDTO.swift
//  App
//
//  Created by Hani on 2022/06/16.
//

import Foundation

struct AppleCredentialRequestDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case authorizationCode
        case identityToken
    }
    
    internal let authorizationCode: Data
    internal let identityToken: Data
    
    init(appleCredential: AppleCredential) {
        self.authorizationCode = appleCredential.authorizationCode
        self.identityToken = appleCredential.identityToken
    }
}
