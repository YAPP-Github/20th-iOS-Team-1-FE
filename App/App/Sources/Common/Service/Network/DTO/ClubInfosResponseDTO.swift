//
//  ClubInfosResponseDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct ClubInfosResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case content
        case pageable
        case totalElements
        case totalPages
        case last
        case size
        case number
        case sort
        case numberOfElements
        case first
        case empty
    }
    
    internal let content: [ContentResponseDTO]
    internal let pageable: PageableDTO
    internal let totalElements: Int
    internal let totalPages: Int
    internal let last: Bool
    internal let size: Int
    internal let number: Int
    internal let sort: SortDTO
    internal let numberOfElements: Int
    internal let first: Bool
    internal let empty: Bool
    
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

struct PageableDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case sort
        case offset
        case pageNumber
        case pageSize
        case paged
        case unpaged
    }
    
    let sort: SortDTO
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

struct SortDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case empty
        case unsorted
        case sorted
    }
    
    let empty, unsorted, sorted: Bool
}
