//
//  ClubDetailInfo.swift
//  App
//
//  Created by Hani on 2022/07/21.
//

import Foundation

struct ClubDetailInfo {
    let id: Int
    let title: String
    let description: String
    let category: GatherCategory?
    let meetingPlace: String
    let latitude: Double
    let longitude: Double
    let startDate: String
    let endDate: String
    let eligiblePetSizeTypes: [PetSizeType]
    let eligibleBreeds: [String]
    let eligibleSex: OwnerSex?
    let maximumPeople: Int
    let participants: Int
}

