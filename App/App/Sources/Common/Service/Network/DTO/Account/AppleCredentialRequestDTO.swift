//
//  AppleCredentialRequestDTO.swift
//  App
//
//  Created by Hani on 2022/06/16.
//

import Foundation

struct AppleCredentialRequestDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case idToken
        case email
    }
    
    internal let idToken: String
    internal let email: String
    
    init(appleCredential: AppleCredential) {
        self.idToken = String(decoding: appleCredential.identityToken, as: UTF8.self)
        self.email = appleCredential.email
    }
}
