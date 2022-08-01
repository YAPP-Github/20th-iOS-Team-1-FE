//
//  ProfileInfo.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

struct ProfileInfo: Equatable {
    var myPage: Bool = true
    var accountInfo: AccountInfo?
    var petInfos: [PetInfo]?
    
    func profileType() -> ProfileType {
        return myPage ? .owner(introduction: accountInfo?.Introduction, pet: petInfos) : .other
    }
    
    enum ProfileType {
        case owner(introduction: String?, pet: [PetInfo]?)
        case other
    }
}
