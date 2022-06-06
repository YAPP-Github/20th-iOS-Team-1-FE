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
        case viewDidLoad
    }
    
    enum Mutation {
        case setCurrentCoordinate
    }
    
    struct State {
        var currentCoordinate: Coordinate = .seoulCityHall
        var currentSpan: Double = 0.005
    }
    
    private var locationManger: LocationManageable
    internal let initialState: State
    
    init(locationManager: LocationManageable) {
        self.locationManger = locationManager
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
    
        case .viewDidLoad:
            return Observable.just(.setCurrentCoordinate)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .setCurrentCoordinate:
            if let newLocation = locationManger.currentLocation() {
                newState.currentCoordinate = Coordinate(
                    latitude: newLocation.coordinate.latitude,
                    longitude: newLocation.coordinate.longitude
                )
            }
        }
        
        return newState
    }
}
