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
        case viewWillAppear
        case settingButtonDidTap
        case introductionRegisterButtonDidTap
        case introductionEditButtonDidTap(text: String)
        case petAddButtonDidTap
        case deletePetList(id: Int)
        case withdrawalDidTap
        case logoutDidTap
        case viewWillDisappear
    }
    
    enum Mutation {
        case loadingProfile(Bool)
        case readyToProfileInfo(ProfileInfo)
        case readyToPresentAlertSheet(Bool)
    }
    
    struct State {
        let nickname: String?
        var profileInfo = ProfileInfo()
        var isLoadingProfile = true
        var shouldPresentAlertSheet = false
    }
    
    let initialState: State
    
    private let profileMainRepository: ProfileMainRepositoryInterface
    private let keychainProvider: KeychainProvidable
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()

    internal var readyToRoot = PublishSubject<Void>()
    internal var readyToProceedRegisterProfile = PublishSubject<Void>()
    internal var readyToProceedEditProfile = PublishSubject<String>()
    internal var readyToProceedAddPet = PublishSubject<Void>()
    internal var readyToReloadPetList = PublishSubject<Void>()
    
    init(nickname: String?, keychainProvider: KeychainProvider, keychainUseCase: KeychainUseCaseInterface, profileMainRepository: ProfileMainRepositoryInterface) {
        initialState = State(nickname: nickname)
        self.keychainProvider = keychainProvider
        self.keychainUseCase = keychainUseCase
        self.profileMainRepository = profileMainRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return getProfileInfo(nickname: currentState.nickname)
        case .introductionRegisterButtonDidTap:
            readyToProceedRegisterProfile.onNext(())
            return Observable.empty()
        case .introductionEditButtonDidTap(text: let text):
            readyToProceedEditProfile.onNext(text)
            return Observable.empty()
        case .petAddButtonDidTap:
            readyToProceedAddPet.onNext(())
            return Observable.empty()
        case .settingButtonDidTap:
            return Observable.just(Mutation.readyToPresentAlertSheet(true))
        case .deletePetList(id: let id):
            deletePet(petID: id)
            return Observable.empty()
        case .withdrawalDidTap:
            withdraw()
            return Observable.empty()
        case .logoutDidTap:
            logout()
            return Observable.empty()
        case .viewWillDisappear:
            return Observable.just(Mutation.readyToPresentAlertSheet(false))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .loadingProfile(let isLoading):
            newState.isLoadingProfile = isLoading
        case .readyToProfileInfo(let profileInfo):
            newState.profileInfo = profileInfo
        case .readyToPresentAlertSheet(let isLoading):
            newState.shouldPresentAlertSheet = isLoading
        }
        return newState
    }
    
    
    private func getProfileInfo(nickname: String?) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
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
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    private func deletePet(petID : Int) {
        self.keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.profileMainRepository.deletePet(accessToken: token, id: petID)
                    .subscribe { result in
                        switch result {
                        case .success:
                            self.readyToReloadPetList.onNext(())
                            return
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
               onFailure: { _,_ in
                    return
               })
            .disposed(by: self.disposeBag)
    }
    
    private func withdraw() {
        self.keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.profileMainRepository.withdraw(accessToken: token)
                    .subscribe { result in
                        switch result {
                        case .success:
                            try? self.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.identifier)
                            try? self.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.refreshToken)
                            self.readyToRoot.onNext(())
                            return
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
               onFailure: { _,_ in
                    return
               })
            .disposed(by: self.disposeBag)
    }
    
    private func logout() {
        self.keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.profileMainRepository.logout(accessToken: token)
                    .subscribe { result in
                        switch result {
                        case .success:
                            try? self.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.identifier)
                            try? self.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.refreshToken)
                            self.readyToRoot.onNext(())
                            return
                        case .failure(let error):
                            print("RESULT FAILURE: ", error.localizedDescription)
                        }
                    }.disposed(by: self.disposeBag)
                },
               onFailure: { _,_ in
                    return
               })
            .disposed(by: self.disposeBag)
    }
}
