//
//  DetailGatherRepositoryInterface.swift
//  App
//
//  Created by Hani on 2022/07/19.
//

import Foundation

import RxSwift

protocol DetailGatherRepositoryInterface {
    func requestDetailGather(accessToken: Data, clubID: Int) -> Single<ClubFindDetail>
    func reportComment(accessToken: Data, commentID: Int) -> Single<Bool>
    func reportClub(accessToken: Data, clubID: Int) -> Single<Bool>
    func deleteComment(accessToken: Data, commentID: String) -> Single<Void>
    func addComment(accessToken: Data, comment: CommentRequest) -> Single<ClubFindDetail>
    func leaveClub(accessToken: Data, clubID: Int) -> Single<Void>
    func deleteClub(accessToken: Data, clubID: Int) -> Single<Void>
    func participateGather(accessToken: Data, clubID: Int) -> Single<String?>
}

