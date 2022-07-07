//
//  StatusDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum StatusDTO: Codable {
    case available
    case personnelFull
    case end
    
    enum CodingKeys: String, CodingKey {
        case available = "AVAILABLE"
        case personnelFull = "PERSONNEL_FULL"
        case end = "END"
    }
}
