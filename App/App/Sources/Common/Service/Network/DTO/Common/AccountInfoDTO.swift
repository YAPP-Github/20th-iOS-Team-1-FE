//
//  AccountInfoDTO.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

struct AccountInfoDTO: Codable {
    let id: Int
    let nickname, address, age, sex: String
    let selfIntroduction: String?
    let interestCategories: [String]?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, nickname, address, age, sex, selfIntroduction, interestCategories
        case imageURL = "imageUrl"
    }
    
    internal func toDomain() -> AccountInfo {
        let accountInfo = AccountInfo(id: id, nickName: nickname, address: address, age: age, sex: sex, Introduction: selfIntroduction, categories: interestCategories, profileImageURL: imageURL)
        
        return accountInfo
    }
}
