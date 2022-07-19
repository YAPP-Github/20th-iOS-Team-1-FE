//
//  LeaderInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct LeaderInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case nickname
        case imageURL = "imageUrl"
    }

    let nickname: String
    let imageURL: String
    
    func toDomain() -> LeaderInfo {
        LeaderInfo(nickname: nickname, imageURL: imageURL)
    }
}

struct LeaderInfo {
    internal let nickname: String
    internal let imageURL: String
}
