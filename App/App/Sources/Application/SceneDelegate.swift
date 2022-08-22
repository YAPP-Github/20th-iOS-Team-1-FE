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
        let networkManager = NetworkManager.shared
        let KeychainQueryRequester = KeychainQueryRequester.shared
        let keychainProvider = KeychainProvider(keyChain: KeychainQueryRequester)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userIdentifierData = (try? keychainProvider.read(service: KeychainService.apple, account: KeychainAccount.identifier)) ?? Data()
        let userIdentifier = String(decoding: userIdentifierData, as: UTF8.self)

        appleIDProvider.getCredentialState(forUserID: userIdentifier) { [weak self] (credentialState, error) in
            guard let self = self else {
                return
            }

            switch credentialState {
            case .authorized:
                self.startCoordinate(window: self.window, start: .tapBar)
            default:
                self.startCoordinate(window: self.window, start: .login)
            }

        }
    }
    
    private func startCoordinate(window: UIWindow?, start: Start) {
        DispatchQueue.main.async { [weak self] in
            self?.appCoordinator = AppCoordinator(window: window, start: start)
            self?.appCoordinator?.start()
        }
    }
}

