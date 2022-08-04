//
//  LoginReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import AuthenticationServices
import Foundation

import ReactorKit
import RxSwift

final class LoginReactor: Reactor {
    enum Action {
        case signInWithApple(authorization: ASAuthorization)
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    let initialState = State()
    
    private let disposeBag = DisposeBag()
    private let appleLoginRepository: AppleLoginRepositoryInterface
    private let keychainProvider: KeychainProvidable
    private let keychainUseCase: KeychainUsecase
    private let profileRepository: ProfileRespository
    internal var readyToProceedWithSignUp = PublishSubject<Void>()
    internal var readyToTogeather = PublishSubject<Void>()
    init(appleLoginRepository: AppleLoginRepositoryInterface, keychainProvider: KeychainProvidable, keychainUseCase: KeychainUsecase, profileRepository: ProfileRespository) {
        self.appleLoginRepository = appleLoginRepository
        self.keychainProvider = keychainProvider
        self.keychainUseCase = keychainUseCase
        self.profileRepository = profileRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(authorization: let authorization):
            signInWithApple(authorization: authorization)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        }
        
        return newState
    }
    
    private func asd() {
        keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.profileRepository.requestProfileInfo(accessToken: token)
                    .subscribe { result in
                        switch result {
                        case .success(let profileInfo):
                            this.readyToTogeather.onNext(()) //로그아웃하고 로그인 다시한거
                        case .failure(let error):
                            this.readyToProceedWithSignUp.onNext(())
                        }
                    }.disposed(by: self.disposeBag)
                },
      
               onFailure: { this,_ in
                    // 첫로그인
               // this.asd(authorization: authorization)
               })
            .disposed(by: self.disposeBag)
    }
        
        
        
    private func signInWithApple(authorization: ASAuthorization) {
        guard let appleCrendential = getAppleCrendential(for: authorization) else {
            return
        }
        
        appleLoginRepository.requestAppleLogin(appleCredential: appleCrendential)
            .subscribe { [weak self] result in
                switch result {
                case .success(let signInResult):
                    guard let accessToken = signInResult.accessToken.data(using: .utf8, allowLossyConversion: false),
                          let refreshToken = signInResult.refreshToken.data(using: .utf8, allowLossyConversion: false),
                          let identifier = appleCrendential.identifier.data(using: .utf8, allowLossyConversion: false) else {
                        return
                    }
                    
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.identifier)
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.accessToken)
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.refreshToken)
                    try? self?.keychainProvider.create(accessToken, service: KeychainService.apple, account: KeychainAccount.accessToken)
                    try? self?.keychainProvider.create(refreshToken, service: KeychainService.apple, account: KeychainAccount.refreshToken)
                    try? self?.keychainProvider.create(identifier, service: KeychainService.apple, account: KeychainAccount.identifier)
                    
                    
                    
                    self?.asd()
                    
            case .failure(_):
                #warning("애플로그인 실패하면 예외처리")
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func getAppleCrendential(for authorization: ASAuthorization) -> AppleCredential? {
        guard let crendential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = crendential.authorizationCode,
              let token = crendential.identityToken else {
            return nil
        }
        
        let identifier = crendential.user
        let appleCredential = AppleCredential(authorizationCode: code, identityToken: token, email: UIDevice.current.identifierForVendor!.uuidString, identifier: identifier)
        
        return appleCredential
    }
    
    private func randomAlphaNumericString() -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in 0 ..< 32 {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }
}
