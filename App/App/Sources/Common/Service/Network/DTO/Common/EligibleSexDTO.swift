//
//  EligibleSexDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum EligibleSexDTO: Codable {
    case man
    case woman
    case all
    
    enum CodingKeys: String, CodingKey {
        case man = "MAN"
        case woman = "WOMAN"
        case all = "ALL"
    }
}
