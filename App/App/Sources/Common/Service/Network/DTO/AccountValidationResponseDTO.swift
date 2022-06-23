//
//  AccountValidationResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/24.
//

import Foundation

struct AccountValidationResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case unique
        case satisfyLengthCondition
    }
    
    internal let unique: Bool
    internal let satisfyLengthCondition: Bool
    
    func toDomain() -> AccountValidation {
        let accountValidation = AccountValidation(unique: unique)
        
        return accountValidation
    }
}
