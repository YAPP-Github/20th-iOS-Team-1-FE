//
//  AddPetRepository.swift
//  App
//
//  Created by 김나희 on 7/12/22.
//

import Foundation

import RxSwift

final class AddPetRepository: AddPetRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
}
