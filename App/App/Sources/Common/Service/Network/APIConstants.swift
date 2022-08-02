//
//  APIConstants.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import Foundation

struct APIConstants {
    // MARK: BASE URL
    static let BaseURL = "https://yapp-togather.com"

    // MARK: Gather List
    static let GetGatherList = "/api/clubs"
    
    // MARK: My Page
    static let GetMyPage = "/api/accounts/my-page"
    
    static let account = "/api/accounts"
    
    static let Pet = "/api/pets"
    
    // MARK: Club
    static let Club = "/api/clubs"

    static let clubLeave = "/api/clubs/leave"
    
    static let clubDelete = "/api/clubs"
    
    static let participate = "/api/clubs/participate"
    
    // MARK: Search
    static let GetSearch = "/api/clubs/search"
    
    static let Range = "/range"
    
    static let Simple = "/simple"

    static let comment = "/api/comments"
    
    // MARK: Report
    static let reportClub = "/api/reports/club"
    
    static let reportComment = "/api/reports/comment"
    
    // MARK: Token
    static let logout = "/api/tokens/expire"
    
}
