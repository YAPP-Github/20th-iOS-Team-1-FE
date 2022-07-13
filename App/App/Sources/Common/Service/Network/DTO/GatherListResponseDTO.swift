//
//  GatherListResponseDTO.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

struct GatherListResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case hasNotClub
        case clubInfos
    }
    
    internal let hasNotClub: Bool
    internal let clubInfos: ClubInfosResponseDTO
    
    func toDomain() -> GatherListInfo {
        let gatherListInfo = GatherListInfo(hasNotClub: hasNotClub, clubInfos: clubInfos.toDomain())
        
        return gatherListInfo
    }
}
