//
//  AccountSummaryInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/23.
//

import Foundation

struct AccountSummaryInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case imageURL = "imageUrl"
    }
    
    let id: Int
    let nickname: String
    let imageURL: String
    
    func toDomain() -> AccountSummaryInfo {
        AccountSummaryInfo(id: id, nickname: nickname, imageURL: imageURL)
    }
}

struct AccountSummaryInfo: Equatable {
    let id: Int
    let nickname: String
    let imageURL: String
}
