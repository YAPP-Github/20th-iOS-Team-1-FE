//
//  ClubFIndDetailResponseDTO.swift
//  App
//
//  Created by Hani on 2022/07/08.
//

import Foundation

struct ClubFIndDetailResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case participating
        case leader
        case clubDetailInfo
        case leaderInfo
        case accountInfos
        case commentInfos
    }
    
    let participating: Bool
    let leader: Bool
    let clubDetailInfo: ClubDetailInfoDTO
    let leaderInfo: LeaderInfoDTO
    let accountInfos: [AccountSummaryInfoDTO]
    let commentInfos: [CommentInfoDTO]
    
    func toDomain() -> ClubFindDetail {
        ClubFindDetail(participating: participating,
                       leader: leader,
                       clubDetailInfo: clubDetailInfo.toDomain(),
                       leaderInfo: leaderInfo.toDomain(),
                       accountInfos: accountInfos.map { $0.toDomain() },
                       commentInfos: commentInfos.map { $0.toDomain() }
        )
    }
}

struct ClubFindDetail {
    let participating: Bool
    let leader: Bool
    let clubDetailInfo: ClubDetailInfo
    let leaderInfo: LeaderInfo
    let accountInfos: [AccountSummaryInfo]
    let commentInfos: [CommentInfo]
}
