//
//  LeaderInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct LeaderInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case imageURL = "imageUrl"
    }
    let id: Int
    let nickname: String
    let imageURL: String?
    
    func toDomain() -> LeaderInfo {
        LeaderInfo(id: id, nickname: nickname, imageURL: imageURL)
    }
}
