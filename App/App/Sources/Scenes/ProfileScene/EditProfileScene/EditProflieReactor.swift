//
//  EditProflieReactor.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxSwift

final class EditProflieReactor: Reactor {
    enum Action {
        case textViewEndEditing(String)
        case registerButtonDidTap
    }
    
    enum Mutation {
        case updateIntroduction(String)
        case readyToRegisterIntroduction(Bool)
        case readyToProceedParentView(Bool)
    }
    
    struct State {
        var introduction: String = ""
        var isRegisterButtonEnabled = false
        var registeredIntroduction = false
    }
    
    let initialState = State()
    private let editProfileRepository: EditProfileRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    
    internal var didRegisterProfile = PublishSubject<Void>()

    init(editProfileRepository: EditProfileRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        self.editProfileRepository = editProfileRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .textViewEndEditing(let text):
            return text.count > 0 && text != "내용을 입력해주세요."
            ? Observable.concat([Observable.just(Mutation.readyToRegisterIntroduction(true)),
                                   Observable.just(Mutation.updateIntroduction(text))])
            : Observable.just(Mutation.readyToRegisterIntroduction(false))
        case .registerButtonDidTap:
            return registerIntroduction(introduction: currentState.introduction)

        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .readyToRegisterIntroduction(let isEnabled):
            newState.isRegisterButtonEnabled = isEnabled
        case .updateIntroduction(let text):
            newState.introduction = text
        case .readyToProceedParentView(let isEnable):
            newState.registeredIntroduction = isEnable
        }
        
        return newState
    }
    
    private func registerIntroduction(introduction: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.editProfileRepository.editProfile(introduction: introduction, accessToken: token)
                        .subscribe(
                            onSuccess: {
                                observer.onNext(Mutation.readyToProceedParentView(true))
                                self.didRegisterProfile.onNext(())
                                return
                            }, onFailure: { _ in
                                observer.onNext(Mutation.readyToProceedParentView(false))
                                return
                            }
                        ).disposed(by: self.disposeBag)
                   },
                   onFailure: { _,_ in
                    observer.onNext(Mutation.readyToProceedParentView(false))
                    return
                }
                ).disposed(by: self.disposeBag)
            
            
            return Disposables.create()
        }
    }
}
