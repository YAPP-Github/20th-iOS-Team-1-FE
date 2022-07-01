//
//  GatherConfigurationForSheet.swift
//  App
//
//  Created by 유한준 on 2022/06/30.
//

import Foundation

struct GatherConfigurationForSheet: Codable {
    let category: String
    let title: String
    let startDate: String
    let endDate: String
    let eligiblePetSizeTypes: [String]
    let eligibleBreeds: [String]
    let eligibleSex: String
    let maximumPeople: Int
    let participants: Int
    let latitude: Double
    let longitude: Double
    let meetingPlace: String
    let distance: Int
    let clubStatus: String
}
