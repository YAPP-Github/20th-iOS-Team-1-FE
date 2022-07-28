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
        case viewWillAppear
        case clubReportDidOccur
        case commentReportDidOccur(Int)
        case commentDidOccur(String)
        case participantDidTap(Int)
    }
    
    enum Mutation {
        case updateDetailGather(ClubFindDetail)
        case updateCommentReportSuccess(Bool)
        case updateClubReportSuccess(Bool)
    }
    
    struct State {
        let clubID: Int
        var isClubReportSuccess = 0
        var isCommentReportSuccess = false
        
        var gatherButtonText = ""
        var gatherButtonEnabled = false
        
        var clubFindDetail: ClubFindDetail?
    }
    
    let initialState: State
    private let disposeBag = DisposeBag()
    private let detailGatherRepository: DetailGatherRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    internal var readyToProfile = PublishSubject<String>()
    init(clubID: Int, detailGatherRepository: DetailGatherRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        initialState = State(clubID: clubID)
        self.detailGatherRepository = detailGatherRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return getGatherDetail(clubID: currentState.clubID)
        case .clubReportDidOccur:
            return reportClub(clubID: currentState.clubID)
        case .commentReportDidOccur(_):
            return reportComment(commentID: 0)
        case .commentDidOccur(_):
            return Observable.empty()
        case .participantDidTap(let id):
            guard let index = currentState.clubFindDetail?.accountInfos.firstIndex(where: { $0.id == id }),
                  let nickname = currentState.clubFindDetail?.accountInfos[safe: index]?.nickname else {
                return Observable.empty()
            }
            readyToProfile.onNext(nickname)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        
        case .updateDetailGather(let clubFindDetail):
            newState.clubFindDetail = clubFindDetail
        case .updateCommentReportSuccess(let isSuccess):
            newState.isCommentReportSuccess = isSuccess
        case .updateClubReportSuccess(let isSuccess):
            newState.isClubReportSuccess += 1
        }
        return newState
    }
    
    private func getGatherDetail(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.requestDetailGather(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(let clubFindDetail):
                            observer.onNext(Mutation.updateDetailGather(clubFindDetail))
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
    
    private func reportClub(clubID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.reportClub(accessToken: token, clubID: clubID)
                        .subscribe { result in
                        switch result {
                        case .success(let isSuccess):
                            observer.onNext(Mutation.updateClubReportSuccess(isSuccess))
                        case .failure(_):
                            observer.onNext(Mutation.updateClubReportSuccess(true))
                        }
                    }.disposed(by: self.disposeBag)
                },
                onFailure: { _,_ in
                     return
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func reportComment(commentID: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.detailGatherRepository.reportComment(accessToken: token, commentID: commentID)
                        .subscribe { result in
                        switch result {
                        case .success(let isSuccess):
                            observer.onNext(Mutation.updateCommentReportSuccess(isSuccess))
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
