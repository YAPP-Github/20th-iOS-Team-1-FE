//
//  CategoryDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum CategoryDTO: Codable {
    case walk
    case dogCafe
    
    enum CodingKeys: String, CodingKey {
        case walk = "WALK"
        case dogCafe = "DOG_CAFE"
    }
}
