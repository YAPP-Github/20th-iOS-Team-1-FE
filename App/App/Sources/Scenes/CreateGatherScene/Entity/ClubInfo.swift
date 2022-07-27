//
//  ClubInfo.swift
//  App
//
//  Created by 김나희 on 7/26/22.
//

import Foundation

struct ClubInfo {
    internal var meetingPlace: String
    internal var category: GatherCategory?
    internal var title: String
    internal var description: String?
    internal var startDate: String
    internal var startTime: String
    internal var endDate: String
    internal var endTime: String
    internal var maximumPeople: Int
    internal var eligibleSex: EligibleSexDTO?
    internal var petSizeType = [PetSizeTypeDTO]()
    internal var eligibleBreed: [String]?
    internal var latitude: Double
    internal var longitude: Double
    
    init(meetingPlace: String,
         title: String = "",
         description: String = "",
         startDate: String = "",
         startTime: String = "",
         endDate: String = "",
         endTime: String = "",
         maximumPeople: Int = 0,
         latitude: Double,
         longitude: Double) {
             
        self.meetingPlace = meetingPlace
        self.title = title
        self.description = description
        self.startDate = startDate
        self.startTime = startTime
        self.endDate = endDate
        self.endTime = endTime
        self.maximumPeople = maximumPeople
        self.latitude = latitude
        self.longitude = longitude
    }
}



