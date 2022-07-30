//
//  CommentRequestDTO.swift
//  App
//
//  Created by Hani on 2022/07/29.
//

import Foundation

struct CommentRequestDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case content
    }
    
    let clubID: Int
    let content: String
    
    init(comment: CommentRequest) {
        self.content = comment.content
        self.clubID = comment.clubID
    }
}

struct CommentRequest {
    let clubID: Int
    let content: String
}
