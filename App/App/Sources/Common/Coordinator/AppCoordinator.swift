//
//  AppCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

import RxSwift

final class AppCoordinator: Coordinator {
    private let window: UIWindow?
    private let keychainUseCase: KeychainUseCaseInterface
    private let profileRepository: ProfileMainRepositoryInterface
    private let disposeBag = DisposeBag()
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()

    init(window: UIWindow?, keychainUseCase: KeychainUseCaseInterface, profileRepository: ProfileMainRepositoryInterface) {
        self.window = window
        self.keychainUseCase = keychainUseCase
        self.profileRepository = profileRepository
    }
    
    func start() {
        keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.profileRepository.requestProfileInfo(accessToken: token)
                    .observe(on: MainScheduler.instance)
                    .subscribe { result in
                        switch result {
                        case .success(let profileInfo):
                            guard let _ = profileInfo.accountInfo,
                                  let _ = profileInfo.petInfos else {
                                this.moveToAuth()
                                return
                            }
                            
                            this.moveToTabBar()
                    
                        case .failure(let _):
                            this.moveToAuth()
                        }
                    }.disposed(by: this.disposeBag)
                },
               onFailure: { _,_ in
                self.moveToAuth()
        })
    }

    private func moveToAuth() {
        let authCoordinator = AuthCoordinator(window: window)
        childCoordinators.append(authCoordinator)
        authCoordinator.delegate = self
        authCoordinator.start()
    }

    private func moveToTabBar() {
        let tabCoordinator = TabCoordinator(window: window)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.delegate = self
        tabCoordinator.start()
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func switchToTabBar() {
        childCoordinators.removeAll()
        moveToTabBar()
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func switchToAuth() {
        childCoordinators.removeAll()
        moveToAuth()
    }
}
