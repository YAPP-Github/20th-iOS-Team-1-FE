//
//  CreateClubRequestDTO.swift
//  App
//
//  Created by 김나희 on 7/27/22.
//

import Foundation

struct CreateClubRequestDTO: Codable {
    internal let meetingPlace: String
    internal let category: String
    internal let title: String
    internal let description: String
    internal let startDate: String
    internal let endDate: String
    internal let maximumPeople: Int
    internal let eligibleSex: String
    internal let eligiblePetSizeTypes: [String]
    internal let eligibleBreeds: [String]
    internal let latitude: Double
    internal let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case meetingPlace
        case category
        case title
        case description
        case startDate
        case endDate
        case maximumPeople
        case eligibleSex
        case eligiblePetSizeTypes
        case eligibleBreeds
        case latitude
        case longitude
    }

    init(clubInfo: ClubInfo) {
        self.meetingPlace = clubInfo.meetingPlace
        self.category = clubInfo.category?.rawValue ?? "ETC"
        self.title = clubInfo.title
        self.description = clubInfo.description ?? ""
        self.startDate = clubInfo.startDate + " " + clubInfo.startTime
        self.endDate = clubInfo.endDate + " " + clubInfo.endTime
        self.maximumPeople = clubInfo.maximumPeople
        self.eligibleSex = clubInfo.eligibleSex?.rawValue ?? "ALL"
        self.eligiblePetSizeTypes = clubInfo.petSizeType.map { $0.rawValue }
        self.eligibleBreeds = clubInfo.eligibleBreed ?? []
        self.latitude = clubInfo.latitude
        self.longitude = clubInfo.longitude
    }
}
