//
//  PetSizeTypeDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum PetSizeTypeDTO: Codable {
    case large
    case medium
    case small
    case all

    enum CodingKeys: String, CodingKey {
        case large = "LARGE"
        case medium = "MEDIUM"
        case small = "SMALL"
        case all = "ALL"
    }
    
    
}

