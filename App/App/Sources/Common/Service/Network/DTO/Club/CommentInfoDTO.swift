//
//  CommentInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct CommentInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case content
        case author
        case leader
        case updatedTime
    }
    
    let id: Int
    let content: String
    let author: String
    let leader: String
    let updatedTime: String
    
    func toDomain() -> CommentInfo {
        CommentInfo(id: id, content: content, author: author, leader: leader, updatedTime: updatedTime)
    }
}
