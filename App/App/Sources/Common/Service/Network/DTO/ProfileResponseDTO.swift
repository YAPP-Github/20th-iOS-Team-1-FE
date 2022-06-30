//
//  ProfileResponseDTO.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

struct ProfileResponseDTO: Codable {
    internal let myPage: Bool
    internal let accountInfo: AccountInfoDTO
    internal let petInfos: [PetInfoDTO]
    
    enum CodingKeys: String, CodingKey {
        case myPage
        case accountInfo
        case petInfos
    }
    
    internal func toDomain() -> ProfileInfo {
        let profileInfo =
        ProfileInfo(
            myPage: myPage,
            accountInfo: accountInfo.toDomain(),
            petInfos: petInfos
                .map { petInfo in
                    petInfo.toDomain()
                }
        )
        
        return profileInfo
    }
}
