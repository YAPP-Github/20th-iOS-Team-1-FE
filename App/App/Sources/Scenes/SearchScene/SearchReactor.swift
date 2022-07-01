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
        case mapViewVisibleRegionDidChanged(CLLocationCoordinate2D, CLLocationCoordinate2D)
    }
    
    enum Mutation {
        case setVisibleCoordinate(CLLocationCoordinate2D)
    }
    
    struct State {
        var visibleCorrdinate: Coordinate = .seoulCityHall
        
        var currentSpan: Double = 0.005
    }

    internal let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {

        case let .mapViewVisibleRegionDidChanged(topLeftCoordinate, rightBottomCoordinate):
//            return Observable.just(.setVisibleCoordinate(newCoordinate))
            return .never()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {

        case .setVisibleCoordinate(let newCoordinate):
            newState.visibleCorrdinate = Coordinate(
                latitude: newCoordinate.latitude,
                longitude: newCoordinate.longitude
            )
        }
        
        return newState
    }
}
