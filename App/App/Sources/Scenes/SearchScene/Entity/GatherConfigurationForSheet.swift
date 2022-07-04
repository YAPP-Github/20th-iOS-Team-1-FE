//
//  GatherConfigurationForSheet.swift
//  App
//
//  Created by 유한준 on 2022/07/05.
//

import Foundation

struct GatherConfigurationForSheet: Equatable {
    var category: GatherCategory
    var title, meetingPlace: String
    var startDate, endDate: Date
    var eligibleBreeds: [String]
    var eligiblePetSizeTypes: [PetSizeType]
    var eligibleSex: OwnerSex
    var maximumPeople: Int
    var participants: Int
    var distance: Int
    var clubStatus: ClubStatus
    
    init(
        category: String,
        title: String,
        meetingPlace: String,
        startDate: String,
        endDate: String,
        eligileBreeds: [String],
        eligiblePetSizeTypes: [String],
        eligibleSex: String,
        maximumPeople: Int,
        participants: Int,
        distance: Int,
        clubStatus: String
    ) {
        self.category = GatherCategory(rawValue: category) ?? .walk
        self.title = title
        self.meetingPlace = meetingPlace
        self.startDate = startDate.toDate() ?? .distantPast
        self.endDate = endDate.toDate() ?? .distantPast
        self.eligibleBreeds = eligileBreeds
        self.eligiblePetSizeTypes = eligiblePetSizeTypes.map { PetSizeType(rawValue: $0) ?? .all }
        self.eligibleSex = OwnerSex(rawValue: eligibleSex) ?? .all
        self.maximumPeople = maximumPeople
        self.participants = participants
        self.distance = distance
        self.clubStatus = ClubStatus(rawValue: clubStatus) ?? .end
    }
        
}
