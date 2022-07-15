//
//  ProfileReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class ProfileReactor: Reactor {
    enum Action {
        case profileInfo(nickname: String?)
        case settingButtonDidTap
        case profileEditButtonDidTap
        case petAddButtonDidTap
    }
    
    enum Mutation {
        case loadingProfile(Bool)
        case readyToProfileInfo(ProfileInfo)
        case readyToPresentAlertSheet
    }
    
    struct State {
        var profileInfo = ProfileInfo()
        var isLoadingProfile = true
        var shouldPresentAlertSheet = false
    }
    
    let initialState = State()
    
    private let profileMainRepository: ProfileMainRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    
    internal var readyToProceedEditProfile = PublishSubject<Void>()
    internal var readyToProceedAddPet = PublishSubject<Void>()
    
    init(keychainUseCase: KeychainUseCaseInterface, profileMainRepository: ProfileMainRepositoryInterface) {
        self.profileMainRepository = profileMainRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .profileInfo(nickname: let nickname):
            return getProfileInfo(nickname: nickname)
        case .profileEditButtonDidTap:
            readyToProceedEditProfile.onNext(())
            return Observable.empty()
        case .petAddButtonDidTap:
            readyToProceedAddPet.onNext(())
            return Observable.empty()
        case .settingButtonDidTap:
            return Observable.just(Mutation.readyToPresentAlertSheet)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .loadingProfile(let isLoading):
            newState.isLoadingProfile = isLoading
        case .readyToProfileInfo(let profileInfo):
            newState.profileInfo = profileInfo
        case .readyToPresentAlertSheet:
            newState.shouldPresentAlertSheet = true
        }
        return newState
    }
    
    
    private func getProfileInfo(nickname: String?) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
//            var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJ5YXBwIiwic3ViIjoidW5pcXVlMSIsImF1ZCI6IkFDQ0VTUyIsImV4cCI6MTY2Nzg0MDQ4NSwiaWF0IjoxNjU0NzAwNDg1LCJhdXRoIjoiVVNFUiJ9.pt_MstkRfFOI_qFn0d1FEmRaOFRsTc2XIAYvtEJHWeJCHAjkTD74Yq-Xl7SbmwUEFvi2FWGma8SToDvu2fXK6A"
//            Single.just(Data(token.utf8))
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.profileMainRepository.requestProfileInfo(accessToken: token, nickname: nickname)
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
                    },
                   onFailure: { _,_ in
                        observer.onNext(Mutation.loadingProfile(false))
                        return
                   })
            return Disposables.create()
        }
    }
}
