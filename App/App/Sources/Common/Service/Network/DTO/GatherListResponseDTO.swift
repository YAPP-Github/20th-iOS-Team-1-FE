//
//  GatherListResponseDTO.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

struct GatherListResponseDTO: Codable {
    internal let hasNotClub: Bool
    internal let clubInfos: ClubInfosResponseDTO
    
    func toDomain() -> GatherListInfo {
        let gatherListInfo = GatherListInfo(hasNotClub: hasNotClub, clubInfos: clubInfos.toDomain())
        
        return gatherListInfo
    }
}


struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

struct Sort: Codable {
    let empty, unsorted, sorted: Bool
}
