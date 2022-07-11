//
//  SearchGatherReactor.swift
//  App
//
//  Created by 유한준 on 2022/07/09.
//

import Foundation

import ReactorKit
import RxSwift
import CoreLocation
import AVFoundation

final class SearchGatherReactor: Reactor {
    enum Action {
        case textFieldEditingChanged(String)
        case textFieldEditingDidEndOnExit(CLLocation?)
    }
    
    enum Mutation {
        case updateKeyword(String)
        case loadingResult(Bool)
    }
    
    struct State {
        var keyword: String = ""
        var isResultLoading: Bool = true
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
            
        case let .textFieldEditingChanged(keyword):
            return Observable.just(.updateKeyword(keyword))
            
        case let .textFieldEditingDidEndOnExit(location):
            return requestSearchGatherResult(keyword: currentState.keyword, category: nil, userLocation: location)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .updateKeyword(keyword):
            newState.keyword = keyword
            
        case .loadingResult(let isSuccess):
            newState.isResultLoading = isSuccess
        }
        
        return newState
    }
    
    private func requestSearchGatherResult(
        keyword: String?,
        category: GatherCategory?,
        userLocation: CLLocation?
    ) -> Observable<Mutation> {
        return Observable.create { [unowned self] observer in
            self.gatherRepository
                .requestGatherSearchResult(keyword: keyword, category: category, eligibleBreed: nil, sex: nil, minimumParticipant: nil, maximumParticipant: nil, page: nil, startLatitude: userLocation?.coordinate.latitude, startLongitude: userLocation?.coordinate.longitude, status: nil)
                .subscribe { result in
                    switch result {
                    case .success(let gatherConfigurationsForSheet):
//                        observer.onNext(
//                            //TODO: Mutation
//                        )
                        print(gatherConfigurationsForSheet)
                        
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                        observer.onNext(Mutation.loadingResult(false))
                    }
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
