//
//  CommentRepositoryInterface.swift
//  App
//
//  Created by Hani on 2022/07/11.
//

import Foundation

import RxSwift

protocol CommentRepositoryInterface {
    func deleteComment(accessToken: Data, commentID: String) -> Single<Void>
}
