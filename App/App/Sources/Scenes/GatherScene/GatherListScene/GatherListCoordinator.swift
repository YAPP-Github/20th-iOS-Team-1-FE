//
//  GatherListCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import RxSwift

final class GatherListCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start1() {
        let networkManager = NetworkManager.shared
        let keychainProvider = KeychainProvider.shared
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let detailGatherRepository = DetailGatherRepository(networkManager: networkManager)
        
        let reactor = DetailGatherReactor(clubID: 6, detailGatherRepository: detailGatherRepository, keychainUseCase: keychainUseCase)
        let viewController = DetailGatherViewController(reactor: reactor)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let keychainProvider = KeychainProvider.shared
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let gatherListRepository = GatherListRepository(networkManager: networkManager)
        let reactor = GatherListReactor(gatherListRepository: gatherListRepository, keychainUseCase: keychainUseCase)
        let viewController = GatherListViewController(reactor: reactor)
        
        reactor.readyToDetailGather
            .asDriver(onErrorJustReturn: 0)
            .drive(with: self,
                   onNext: { this, id in
                this.pushDetailGatherViewController(clubID: id)
            })
            .disposed(by:disposeBag)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func pushDetailGatherViewController(clubID: Int) {
        let networkManager = NetworkManager.shared
        let keychainProvider = KeychainProvider.shared
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let detailGatherRepository = DetailGatherRepository(networkManager: networkManager)
        
        let reactor = DetailGatherReactor(clubID: clubID, detailGatherRepository: detailGatherRepository, keychainUseCase: keychainUseCase)
        let viewController = DetailGatherViewController(reactor: reactor)
        
        reactor.readyToProfile
            .asDriver(onErrorJustReturn: "")
            .drive(with: self,
                   onNext: { this, nickname in
                this.pushProfileViewController(nickname: nickname)
            })
            .disposed(by:disposeBag)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushProfileViewController(nickname: String) {
        let networkManager = NetworkManager.shared
        let profileMainRepository = ProfileRespository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let reactor = ProfileReactor(nickname: nickname, keychainUseCase: keychainUseCase, profileMainRepository: profileMainRepository)
        let viewController = ProfileViewController(reactor: reactor)
        
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
