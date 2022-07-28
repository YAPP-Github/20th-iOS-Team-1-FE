//
//  GatherListRepositoryInterface.swift
//  App
//
//  Created by 김나희 on 7/4/22.
//

import Foundation

import RxSwift

protocol GatherListRepositoryInterface {
    func requestGatherList(lastID: String?, endDate: String?, gatherCondition: Gather, accessToken: Data) -> Single<GatherListInfo>
}
