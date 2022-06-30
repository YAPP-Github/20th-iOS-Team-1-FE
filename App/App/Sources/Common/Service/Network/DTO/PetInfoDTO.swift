//
//  PetInfoDTO.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

struct PetInfoDTO: Codable {
    let nickname, breed, age, sex: String
    let tags: [String]
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case nickname, breed, age, sex, tags
        case imageURL = "imageUrl"
    }
    
    internal func toDomain() -> PetInfo {
        let petInfo = PetInfo(nickName: nickname, breed: breed, age: age, tags: tags, imageURL: imageURL)
        
        return petInfo
    }
}

