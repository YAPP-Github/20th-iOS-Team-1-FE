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
        case commentInfos
    }
    #warning("디티오 다시 만들어라")
    let participating: Bool
    let leader: Bool
    let clubDetailInfo: ClubDetailInfoDTO
    let leaderInfo: LeaderInfoDTO
    let commentInfos: [CommentInfoDTO]
}
