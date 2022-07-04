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
    case etc
    
    enum CodingKeys: String, CodingKey {
        case walk = "WALK"
        case dogCafe = "DOG_CAFE"
        case etc = "ETC"
    }
}
