//
//  SceneDelegate.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import AuthenticationServices
import UIKit

import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        startCoordinate(window: window, start: .tapBar)
//        let networkManager = NetworkManager.shared
//        let profileRepository = ProfileRespository(networkManager: networkManager)
//        let keychain = KeychainQueryRequester.shared
//        let keychainProvider = KeychainProvider(keyChain: keychain)
//        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
//
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let userIdentifierData = (try? keychainProvider.read(service: KeychainService.apple, account: KeychainAccount.identifier)) ?? Data()
//        let userIdentifier = String(decoding: userIdentifierData, as: UTF8.self)
//
//        appleIDProvider.getCredentialState(forUserID: userIdentifier) { [weak self] (credentialState, error) in
//            guard let self = self else {
//                return
//            }
//
//            print(credentialState, error)
//
//            print(userIdentifier, Date())
//            switch credentialState {
//            case .authorized:
//                keychainUseCase.getAccessToken()
//                    .subscribe(with: self,
//                       onSuccess: { this, token in
//                        profileRepository.requestProfileInfo(accessToken: token)
//                            .subscribe { result in
//                                switch result {
//                                case .success(_):
//                                    this.startCoordinate(window: this.window, start: .tapBar)
//                                    return
//                                case .failure(_):
//                                    this.startCoordinate(window: this.window, start: .agreement)
//                                    return
//                                }
//                            }.disposed(by: this.disposeBag)
//                        },
//                       onFailure: { this, _ in
//                        this.startCoordinate(window: this.window, start: .login)
//                    }).disposed(by: self.disposeBag)
//            case .revoked:
//                self.startCoordinate(window: self.window, start: .login)
//            default:
//                self.startCoordinate(window: self.window, start: .login)
//            }
//        }
    }
    
    private func startCoordinate(window: UIWindow?, start: Start) {
        DispatchQueue.main.async { [weak self] in
            self?.appCoordinator = AppCoordinator(window: window, start: start)
            self?.appCoordinator?.start()
        }
    }
}

