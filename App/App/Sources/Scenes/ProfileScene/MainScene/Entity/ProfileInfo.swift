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
}
