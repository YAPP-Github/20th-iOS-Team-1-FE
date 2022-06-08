//
//  SearchingResponseDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct SearchingResponseDTO: Codable {
    internal let searchingClubDTOs: [SearchingClubDTO]
    
    enum CodingKeys: String, CodingKey {
        case searchingClubDTOs = "searchingClubDto"
    }
}
