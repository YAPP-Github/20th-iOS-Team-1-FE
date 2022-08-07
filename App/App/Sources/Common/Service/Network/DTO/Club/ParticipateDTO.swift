//
//  ParticipateDTO.swift
//  App
//
//  Created by 김나희 on 8/6/22.
//

import Foundation

struct ParticipateDTO: Codable {
    let eligible: Bool
    let rejectReason: String?
    let clubID, accountClubID: Int

    enum CodingKeys: String, CodingKey {
        case eligible, rejectReason
        case clubID = "clubId"
        case accountClubID = "accountClubId"
    }
}
