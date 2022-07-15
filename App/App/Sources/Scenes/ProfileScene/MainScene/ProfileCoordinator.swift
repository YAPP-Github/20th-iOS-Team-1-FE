//
//  ProfileCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import RxSwift

final class ProfileCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let profileMainRepository = ProfileRespository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let reactor = ProfileReactor(keychainUseCase: keychainUseCase, profileMainRepository: profileMainRepository)
        let viewController = ProfileViewController(reactor: reactor)
        
        reactor.readyToProceedEditProfile
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushEditProfileViewController()
            })
            .disposed(by: disposeBag)
        
        reactor.readyToProceedAddPet
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushAddPetViewController()
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func pushEditProfileViewController() {
        let networkManager = NetworkManager.shared
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)

        let editProfileRepository = EditProfileRepository(networkManager: NetworkManager.shared)
        let editProflieReactor = EditProflieReactor(editProfileRepository: editProfileRepository, keychainUseCase: keychainUseCase)
        let editProfileViewController = EditProfileViewController(reactor: editProflieReactor)
                
        navigationController.pushViewController(editProfileViewController, animated: true)
    }
    
    func pushAddPetViewController() {
        let addPetRepository = AddPetRepository(networkManager: NetworkManager.shared)
        let addPetReactor = AddPetReactor(addPetRepository: addPetRepository)
        let addPetViewController = AddPetViewController(reactor: addPetReactor)

        navigationController.pushViewController(addPetViewController, animated: true)
    }
}
