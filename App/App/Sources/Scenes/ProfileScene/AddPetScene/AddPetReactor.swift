//
//  AddPetReactor.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxSwift

final class AddPetReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState = State()
    
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
