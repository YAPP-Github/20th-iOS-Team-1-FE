//
//  ClubInfosResponseDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct ClubInfosResponseDTO: Codable {
    internal let content: [ContentResponseDTO]
    internal let totalElements, totalPages: Int
    internal let last: Bool
    internal let size, number: Int
    internal let numberOfElements: Int
    internal let first, empty: Bool
    
    func toDomain() -> ClubInfos {
        let clubInfos = ClubInfos(content: content.map { element in element.toDomain() },
                                  totalElements: totalElements,
                                  totalPages: totalPages,
                                  last: last,
                                  size: size,
                                  number: number,
                                  numberOfElements: numberOfElements,
                                  first: first,
                                  empty: empty)
        
        return clubInfos
    }
}
