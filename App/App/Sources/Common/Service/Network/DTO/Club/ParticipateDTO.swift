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
    let clubID: Int
    let accountClubID: Int?

    enum CodingKeys: String, CodingKey {
        case eligible, rejectReason
        case clubID = "clubId"
        case accountClubID = "accountClubId"
    }
}

enum RejectReason: String {
    case noPet = "HAS_NOT_PET"
    case size = "NOT_ELIGIBLE_PET_SIZE_TYPE"
    case breed = "NOT_ELIGIBLE_BREEDS"
    case sex = "NOT_ELIGIBLE_SEX"

    func toKorean() -> String {
        switch self {
        case .noPet:
            return "참여할 반려견 정보가 없습니다."
        case .size:
            return "참여 불가능한 반려견 크기입니다."
        case .breed:
            return "참여 불가능한 견종입니다."
        case .sex:
            return "참여 불가능한 견주 성별입니다."
        }
    }
}
