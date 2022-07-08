//
//  SceneDelegate.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let networkManager = NetworkManager.shared
        let profileRepository = ProfileRespository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        
        window = UIWindow(windowScene: windowScene)
        
        appCoordinator = AppCoordinator(window: window, keychainUseCase: keychainUseCase, profileRepository: profileRepository)
        appCoordinator?.start()
    }
}

