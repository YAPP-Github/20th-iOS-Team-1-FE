//
//  GatherListReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxSwift

final class GatherListReactor: Reactor {
    enum Action {
        case segmentIndex(index: Int)
        case gatherListCellDidTap(clubID: Int)
    }
    
    enum Mutation {
        case readyToListInfo(GatherListInfo)
        case readyToProceedDetailGatherView(Int)
    }
    
    struct State {
        var gatherListInfo = GatherListInfo(hasNotClub: false)
        var isReadyToProceedDetailGatherView = (false, 0)
    }
    
    private let disposeBag = DisposeBag()
    private let gatherListRepository: GatherListRepositoryInterface
    
    init(gatherListRepository: GatherListRepositoryInterface) {
        self.gatherListRepository = gatherListRepository
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .segmentIndex(index: let index):
            return getGatherList(index)
        case .gatherListCellDidTap(clubID: let clubID):
            return Observable.just(Mutation.readyToProceedDetailGatherView(clubID))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .readyToListInfo(let data):
            newState.gatherListInfo = data
            newState.isReadyToProceedDetailGatherView = (false, 0)
        case .readyToProceedDetailGatherView(let clubID):
            newState.isReadyToProceedDetailGatherView = (true, clubID)
        }
        
        return newState
    }
    
    
    private func getGatherList(_ index: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }

            self.gatherListRepository.requestGatherList(club: index)
                .subscribe { result in
                    switch result {
                    case .success(let gatherListInfo):
                        let hasNotClub = gatherListInfo.hasNotClub
                        guard let clubInfo = gatherListInfo.clubInfos?.content else {
                            return
                        }
                        observer.onNext(Mutation.readyToListInfo(GatherListInfo(hasNotClub: gatherListInfo.hasNotClub, clubInfos: gatherListInfo.clubInfos)))
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
