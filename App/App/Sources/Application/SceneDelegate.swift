//
//  SceneDelegate.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

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
        
//        let networkManager = NetworkManager.shared
//        let profileRepository = ProfileRespository(networkManager: networkManager)
//        let keychain = KeychainQueryRequester()
//        let keychainProvider = KeychainProvider(keyChain: keychain)
//        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        
//        keychainUseCase.getAccessToken()
//            .subscribe(with: self,
//               onSuccess: { this, token in
//                profileRepository.requestProfileInfo(accessToken: token)
//                    .observe(on: MainScheduler.instance)
//                    .subscribe { result in
//                        switch result {
//                        case .success(let profileInfo):
//                            guard let _ = profileInfo.accountInfo,
//                                  let _ = profileInfo.petInfos else {
//                                this.startCoordinate(window: this.window, isLoggedIn: false)
//                                return
//                            }
//
//                            this.startCoordinate(window: this.window, isLoggedIn: true)
//                            return
//                        case .failure(_):
//                            this.startCoordinate(window: this.window, isLoggedIn: false)
//                            return
//                        }
//                    }.disposed(by: this.disposeBag)
//                },
//               onFailure: { this, _ in
//                this.startCoordinate(window: this.window, isLoggedIn: false)
//                return
//            }).disposed(by: disposeBag)
        startCoordinate(window: window, isLoggedIn: false)
    }
    
    private func startCoordinate(window: UIWindow?, isLoggedIn: Bool) {
        appCoordinator = AppCoordinator(window: window, isLoggedIn: isLoggedIn)
        appCoordinator?.start()
    }
}

