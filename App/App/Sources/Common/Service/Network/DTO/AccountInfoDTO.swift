//
//  AccountInfoDTO.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

struct AccountInfoDTO: Codable {
    let nickname, address, age, sex: String
    let selfIntroduction: String
    let interestCategories: [String]
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case nickname, address, age, sex, selfIntroduction, interestCategories
        case imageURL = "imageUrl"
    }
    
    internal func toDomain() -> AccountInfo {
        let accountInfo = AccountInfo(nickName: nickname, address: address, age: age, Introduction: selfIntroduction, categories: interestCategories, profileImageURL: imageURL)
        
        return accountInfo
    }
}
