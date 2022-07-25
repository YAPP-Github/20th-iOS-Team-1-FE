//
//  CreateGatherReactor.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class CreateGatherReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState = State()
    private let createGatherRepository: CreateGatherRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    
    init(createGatherRepository: CreateGatherRepository, keychainUseCase: KeychainUseCaseInterface) {
        self.createGatherRepository = createGatherRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}
