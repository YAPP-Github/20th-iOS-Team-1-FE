//
//  SearchGatherReactor.swift
//  App
//
//  Created by 유한준 on 2022/07/09.
//

import Foundation

import ReactorKit
import RxSwift

final class SearchGatherReactor: Reactor {
    enum Action {
        case textFieldDidEndEditing(String)
    }
    
    enum Mutation {
        case updateKeyword(String)
    }
    
    struct State {
        var keyword = ""
    }
    
    internal let initialState: State
    private let disposeBag = DisposeBag()
    private let gatherRepository: GatherRepositoryInterface
    
    init(gatherRepository: GatherRepositoryInterface) {
        self.initialState = State()
        self.gatherRepository = gatherRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case let .textFieldDidEndEditing(keyword):
            return Observable.just(.updateKeyword(keyword))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .updateKeyword(keyword):
            newState.keyword = keyword
        }
        
        return newState
    }
}
