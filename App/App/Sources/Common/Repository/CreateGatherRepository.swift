//
//  CreateGatherRepository.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import Foundation

import RxSwift

final class CreateGatherRepository: CreateGatherRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
}
