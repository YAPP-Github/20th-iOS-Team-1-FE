//
//  CommentInfo.swift
//  App
//
//  Created by Hani on 2022/07/21.
//

import Foundation

struct CommentInfo: Equatable {
    let id: Int
    let content: String
    let author: String
    let leader: Bool
    let updatedTime: String
    let breeds: [String]
    let imageURL: String
}
