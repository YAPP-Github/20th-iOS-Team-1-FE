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
//        let keychain = KeychainQueryRequester.shared
//        let keychainProvider = KeychainProvider(keyChain: keychain)
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let userIdentifierData = (try? keychainProvider.read(service: KeychainService.apple, account: KeychainAccount.identifier)) ?? Data()
//        let userIdentifier = String(decoding: userIdentifierData, as: UTF8.self)
//
//        appleIDProvider.getCredentialState(forUserID: userIdentifier) { [weak self] (credentialState, error) in
//            guard let self = self else {
//                return
//            }
//
//            switch credentialState {
//            case .authorized:
//                let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
//                let profileRepository = ProfileRespository(networkManager: networkManager)
//                let keychain = keychainUseCase.getAccessToken()
//                
//                keychain.subscribe(
//                    onSuccess: { token in
//                        let profile = profileRepository.requestProfileInfo(accessToken: token)
//            
//                        profile.subscribe { result in
//                            switch result {
//                            case .success(_):
//                                self.startCoordinate(window: self.window, start: .tapBar)
//                                return
//                            case .failure(_):
//                                self.startCoordinate(window: self.window, start: .agreement)
//                                return
//                            }
//                        }.disposed(by: self.disposeBag)
//                    },
//                    onFailure: { _ in
//                        self.startCoordinate(window: self.window, start: .login)
//                    }
//                ).disposed(by: self.disposeBag)
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

