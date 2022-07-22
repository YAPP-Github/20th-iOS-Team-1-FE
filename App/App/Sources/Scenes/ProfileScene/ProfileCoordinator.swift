//
//  ProfileCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import RxSwift

protocol SendData: AnyObject {
    func sendData(data: String)
}

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
            .asDriver(onErrorJustReturn: "")
            .drive(with: self,
                   onNext: { this, text in
                this.pushEditProfileViewController(text)
            })
            .disposed(by: disposeBag)
        
        reactor.readyToProceedRegisterProfile
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushEditProfileViewController(nil)
            })
            .disposed(by: disposeBag)
        
        reactor.readyToProceedAddPet
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushAddPetViewController()
            })
            .disposed(by: disposeBag)
        
        reactor.readyToReloadPetList
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.start()
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func pushEditProfileViewController(_ text: String?) {
        let networkManager = NetworkManager.shared
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let editProfileRepository = EditProfileRepository(networkManager: NetworkManager.shared)
        let editProfileReactor = EditProflieReactor(editProfileRepository: editProfileRepository, keychainUseCase: keychainUseCase)
        let editProfileViewController = EditProfileViewController(reactor: editProfileReactor)
        editProfileViewController.introduceTextView.text = text ?? "내용을 입력해주세요."
        
        editProfileReactor.didRegisterProfile
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
                
        navigationController.pushViewController(editProfileViewController, animated: true)
    }
    
    func pushAddPetViewController() {
        let networkManager = NetworkManager.shared
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let addPetRepository = AddPetRepository(networkManager: NetworkManager.shared)
        let addPetReactor = AddPetReactor(addPetRepository: addPetRepository, keychainUseCase: keychainUseCase)
        let addPetViewController = AddPetViewController(reactor: addPetReactor)
        
        addPetReactor.readyToProceedSearchBreed
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                let reactor = SearchBreedReactor()
                let viewController = SearchBreedViewController(reactor: reactor)
                viewController.delegate = addPetViewController
                this.pushSearchBreedViewController(viewController)
            })
            .disposed(by: disposeBag)
        
        addPetReactor.readyToProceedProfile
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(addPetViewController, animated: true)
    }
    
    func pushSearchBreedViewController(_ viewController: SearchBreedViewController) {
        viewController.reactor?.readyToRegisterBreed
            .asDriver(onErrorJustReturn: [])
            .drive(with: self,
                   onNext: { this, breed in
                viewController.delegate?.sendData(data: breed.first!)
                self.navigationController.popViewController(animated: true)
            })
            .disposed(by: disposeBag)


        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss(animated: Bool) {
        navigationController.popViewController(animated: animated)
        start()
    }
}
