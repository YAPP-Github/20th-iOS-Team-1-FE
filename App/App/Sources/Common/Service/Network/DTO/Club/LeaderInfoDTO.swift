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
}
