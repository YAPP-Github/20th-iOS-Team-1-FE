//
//  CommentInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct CommentInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case content
        case author
        case leader
        case updatedTime
    }
    
    let content: String
    let author: String
    let leader: String
    let updatedTime: String
    
    func toDomain() -> CommentInfo {
        CommentInfo(content: content, author: author, leader: leader, updatedTime: updatedTime)
    }
}

struct CommentInfo {
    let content: String
    let author: String
    let leader: String
    let updatedTime: String
}
