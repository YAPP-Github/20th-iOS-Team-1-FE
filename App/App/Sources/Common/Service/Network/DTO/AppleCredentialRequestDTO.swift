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
    }
    
    internal let idToken: String
    
    init(appleCredential: AppleCredential) {
        self.idToken = String(decoding: appleCredential.identityToken, as: UTF8.self)
    }
}
