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
        case setMapViewAnnotation([GatherConfigurationForAnnotation])
        case loadingAnnotation(Bool)
    }
    
    struct State {
        var visibleCorrdinate: Coordinate = .seoulCityHall
        var currentSpan: Double = 0.005
        var annotations: [GatherConfigurationForAnnotation] = []
        var isAnnotationLoading: Bool = true
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
            
        case let .mapViewVisibleRegionDidChanged(topLeftCoordinate, rightBottomCoordinate):
            return searchMapViewAnnotation(
                topLeftCoordinate: topLeftCoordinate,
                rightBottomCoordinate: rightBottomCoordinate
            )
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
            
        case .setMapViewAnnotation(let gatherConfigurationsForAnnotation):
            newState.annotations = gatherConfigurationsForAnnotation
            
        case .loadingAnnotation(let isSuccess):
            newState.isAnnotationLoading = isSuccess
        }
        
        return newState
    }
    
    private func searchMapViewAnnotation(
        topLeftCoordinate: CLLocationCoordinate2D,
        rightBottomCoordinate: CLLocationCoordinate2D
    ) -> Observable<Mutation> {
        return Observable.create { [unowned self] observer in
            self.gatherRepository
                .requestGatherConfigurationForAnnotation(
                    topLeftCoordinate: topLeftCoordinate,
                    bottomRightCoordinate: rightBottomCoordinate
                )
                .subscribe { result in
                    switch result {
                    case .success(let gatherConfigrationsForAnnotations):
                        observer.onNext(
                            Mutation.setMapViewAnnotation(gatherConfigrationsForAnnotations)
                        )
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                        observer.onNext(Mutation.loadingAnnotation(false))
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
