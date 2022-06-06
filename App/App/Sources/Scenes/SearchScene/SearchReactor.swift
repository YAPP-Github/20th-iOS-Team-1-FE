//
//  SearchReactor.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import CoreLocation
import Foundation

import ReactorKit
import RxSwift

final class SearchReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var currentCoordinate: Coordinate = .seoulCityHall
        var currentSpan: Double = 0.005
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
