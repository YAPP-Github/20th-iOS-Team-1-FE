//
//  SignUpProfileReactor.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import UIKit

import ReactorKit
import RxSwift

final class SignUpProfileReactor: Reactor {
    enum Action {
        case profileRegisterButtonDidTap
        case textFieldDidEndEditing(String)
        case duplicateCheckButtonDidTap
        case nextButtonDidTap
    }
    
    enum Mutation {
        case changeProfileImage(Data?)
        case validateNicknameLength(Bool)
        case updateNickname(String)
        case checkNicknameDuplication(String?)
        case readyToProceedWithSignUp
    }
    
    struct State {
        var nickname = ""
        var user: UserAccount
        var isNicknameValidationCheckDone = false
        var isNicknameDuplicateCheckDone = false
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState: State
    
    private let regularExpressionValidator: RegularExpressionValidatable
    private let accountValidationRepository: AccountValidationRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    
    init(user: UserAccount, regularExpressionValidator: RegularExpressionValidatable, accountValidationRepository: AccountValidationRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        self.initialState = State(user: user)
        self.regularExpressionValidator = regularExpressionValidator
        self.accountValidationRepository = accountValidationRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .profileRegisterButtonDidTap:
            return checkDuplication(nickname: "temp")
        case .textFieldDidEndEditing(let nickname):
            let isValid = regularExpressionValidator.validate(nickname: nickname)
            return Observable.concat([Observable.just(Mutation.validateNicknameLength(isValid)),
                                      Observable.just(Mutation.updateNickname(nickname))])
        case .duplicateCheckButtonDidTap:
            //return checkDuplication(nickname: self.currentState.nickname)
            return Observable.just(.checkNicknameDuplication("aaaa"))
        case .nextButtonDidTap:
            return Observable.just(Mutation.readyToProceedWithSignUp)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case.changeProfileImage(let data):
            newState.user.profileImageData = data
        case .validateNicknameLength(let isValid):
            newState.isNicknameValidationCheckDone = isValid
        case .checkNicknameDuplication(let checkedNickname):
            newState.user.nickName = checkedNickname
            newState.isNicknameDuplicateCheckDone = (checkedNickname != nil)
        case .readyToProceedWithSignUp:
            newState.isReadyToProceedWithSignUp = true
        case .updateNickname(let nickname):
            newState.nickname = nickname
        }
        
        return newState
    }
    
    private func checkDuplication(nickname: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                        this.accountValidationRepository.validateDuplicationAndLength(nickname: nickname, accessToken: token)
                        .subscribe(
                            onSuccess: { validation in
                                let result = validation.unique ? nickname : nil
                                observer.onNext(Mutation.checkNicknameDuplication(result))
                                return
                            
                            }, onFailure: { _ in
                                observer.onNext(Mutation.checkNicknameDuplication(nil))
                                return
                            }
                        ).disposed(by: self.disposeBag)
                   },
                   onFailure: { _,_ in
                        observer.onNext(Mutation.checkNicknameDuplication(nil))
                        return
                   }
                ).disposed(by: self.disposeBag)
            
            
            return Disposables.create()
        }
    }
}


