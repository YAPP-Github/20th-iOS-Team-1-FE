//
//  SexDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum SexDTO: Codable {
    case man
    case woman
    case `private`
    
    enum CodingKeys: String, CodingKey {
        case man = "MAN"
        case woman = "WOMAN"
        case `private` = "PRIVATE"
    }
}
