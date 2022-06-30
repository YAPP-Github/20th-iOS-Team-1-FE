//
//  ProfileReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxSwift

final class ProfileReactor: Reactor {
    enum Action {
        case profileInfo(nickname: String?)
        case profileEditButtonDidTap
        case petAddButtonDidTap
    }
    
    enum Mutation {
        case loadingProfile(Bool)
        case readyToProfileInfo(ProfileInfo)
        case readyToProceedEditProfile
        case readyToProceedAddPet
    }
    
    struct State {
        var profileInfo = ProfileInfo()
        var isLoadingProfile = true
        var isReadyToProceedEditProfile = false
        var isReadyToProceedAddPet = false
    }
    
    let initialState = State()
    private let disposeBag = DisposeBag()
    private let profileMainRepository: ProfileMainRepositoryInterface
    
    init(profileMainRepository: ProfileMainRepositoryInterface) {
        self.profileMainRepository = profileMainRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .profileInfo(nickname: let nickname):
            return getProfileInfo(nickname: nickname)
        case .profileEditButtonDidTap:
            return Observable.just(Mutation.readyToProceedEditProfile)
        case .petAddButtonDidTap:
            return Observable.just(Mutation.readyToProceedAddPet)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .loadingProfile(let isLoading):
            newState.isLoadingProfile = isLoading
        case .readyToProfileInfo(let profileInfo):
            newState.profileInfo = profileInfo
        case .readyToProceedEditProfile:
            newState.isReadyToProceedEditProfile = true
            newState.isReadyToProceedAddPet = false
        case .readyToProceedAddPet:
            newState.isReadyToProceedAddPet = true
            newState.isReadyToProceedEditProfile = false
        }
        return newState
    }
    
    
    private func getProfileInfo(nickname: String?) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let nickname = nickname else {
                observer.onNext(Mutation.loadingProfile(false))
                return Disposables.create()
            }

            self.profileMainRepository.requestProfileInfo(nickname: nickname)
                .subscribe { result in
                    switch result {
                    case .success(let profileInfo):
                        let myAccount = profileInfo.myPage
                        guard let accountInfo = profileInfo.accountInfo,
                              let petInfo = profileInfo.petInfos else {
                            observer.onNext(Mutation.loadingProfile(false))
                            return
                        }
                        observer.onNext(Mutation.readyToProfileInfo(ProfileInfo(myPage: myAccount, accountInfo: accountInfo, petInfos: petInfo)))
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                        observer.onNext(Mutation.loadingProfile(false))
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
