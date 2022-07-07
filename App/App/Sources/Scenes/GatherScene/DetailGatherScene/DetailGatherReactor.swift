//
//  DetailGatherReactor.swift
//  App
//
//  Created by Hani on 2022/07/04.
//

import Foundation

import ReactorKit
import RxSwift

final class DetailGatherReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let clubID: Int
    }
    
    let initialState: State
    
    init(clubID: Int) {
        initialState = State(clubID: clubID)
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
