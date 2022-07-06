//
//  GatherListInfo.swift
//  App
//
//  Created by 김나희 on 7/4/22.
//

import Foundation

struct GatherListInfo: Equatable {
    var hasNotClub: Bool
    var clubInfos: ClubInfos?
}

struct ClubInfos: Equatable {
    var content: [Content]?
    var totalElements, totalPages: Int
    var last: Bool
    var size, number: Int
    var numberOfElements: Int
    var first, empty: Bool
}

struct Content: Equatable {
    var clubID: Int
    var title, category, meetingPlace: String?
    var startDate, endDate: String?
    var eligibleBreeds: [String]?
    var eligiblePetSizeTypes: [String]?
    var eligibleSex: String?
    var maximumPeople, participants: Int

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case title, category, meetingPlace, startDate, endDate, eligibleBreeds, eligiblePetSizeTypes, eligibleSex, maximumPeople, participants
    }
}
