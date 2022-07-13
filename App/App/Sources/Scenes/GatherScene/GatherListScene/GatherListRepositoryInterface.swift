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

extension GatherListRepositoryInterface {
    func requestGatherList(gatherCondition: Gather, accessToken: Data) -> Single<GatherListInfo> {
        requestGatherList(lastID: nil, endDate: nil, gatherCondition: gatherCondition, accessToken: accessToken)
    }
}
