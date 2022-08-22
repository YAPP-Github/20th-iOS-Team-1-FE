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
        case viewWillAppear
        case segmentIndex(index: Int)
        case gatherListCellDidTap(clubID: Int)
    }
    
    enum Mutation {
        case readyToListInfo(Gather, GatherListInfo)
    }
    
    struct State {
        var currentIdx: Int = 0
        var gatherListInfo: GatherListInfo
        var gatherType: Gather
    }
    
    private let disposeBag = DisposeBag()
    private let gatherListRepository: GatherListRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    internal var readyToDetailGather = PublishSubject<Int>()
    init(gatherListRepository: GatherListRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        self.initialState = State(gatherListInfo: GatherListInfo(hasNotClub: true), gatherType: .participating)
        self.gatherListRepository = gatherListRepository
        self.keychainUseCase = keychainUseCase
    }
    
    let initialState: State
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            guard let gatherCondition = Gather.init(rawValue: 0) else {
                return Observable.empty()
            }
            return getGatherList(gatherCondition)
        case .segmentIndex(index: let index):
            guard let gatherCondition = Gather.init(rawValue: index) else {
                return Observable.empty()
            }
            return getGatherList(gatherCondition)
        case .gatherListCellDidTap(clubID: let clubID):
            readyToDetailGather.onNext(clubID)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .readyToListInfo(let gatherType, let data):
            newState.gatherListInfo = data
            newState.gatherType = gatherType
            
        return newState
        }
    }
    
    
    private func getGatherList(_ gather: Gather) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.gatherListRepository.requestGatherList(lastID: nil, endDate: nil, gatherCondition: gather, accessToken: token)
                        .subscribe { result in
                        switch result {
                        case .success(let gatherListInfo):
                            observer.onNext(Mutation.readyToListInfo(gather, gatherListInfo))
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
