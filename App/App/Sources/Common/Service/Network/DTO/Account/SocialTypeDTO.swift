//
//  SocialTypeDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum SocialTypeDTO: Codable {
    case apple
    case kakao
    
    enum CodingKeys: String, CodingKey {
        case apple = "APPLE"
        case kakao = "KAKAO"
    }
}
