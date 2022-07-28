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
    var title, meetingPlace: String
    var category: GatherCategory?
    var startDate, endDate: Date?
    var eligibleBreeds: [String]?
    var eligiblePetSizeTypes: [PetSizeType]
    var eligibleSex: OwnerSex
    var maximumPeople,participants: Int
    
    
    init(clubID: Int,
         title: String,
         category: String,
         meetingPlace: String,
         startDate: String,
         endDate: String,
         eligibleBreeds: [String]?,
         eligiblePetSizeTypes: [String],
         eligibleSex: String,
         maximumPeople: Int,
         participants: Int
    ) {
        self.clubID = clubID
        self.title = title
        self.category = GatherCategory(rawValue: category)
        self.meetingPlace = meetingPlace
        self.startDate = startDate.toDate()
        self.endDate = endDate.toDate()
        self.eligibleBreeds = eligibleBreeds
        self.eligiblePetSizeTypes = eligiblePetSizeTypes.map { PetSizeType(rawValue: $0) ?? .all }
        self.eligibleSex = OwnerSex(rawValue: eligibleSex) ?? .all
        self.maximumPeople = maximumPeople
        self.participants = participants
    }
}
