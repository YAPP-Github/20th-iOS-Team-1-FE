//
//  SearchCoordinator.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import CoreLocation
import UIKit

import RxSwift

final class SearchCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    let locationManger = CLLocationManager()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO: KeyChainProvider
        let gatherRepository = GatherRepository(networkManager: NetworkManager.shared)
        let searchReactor = SearchReactor(gatherRepository: gatherRepository)
        let viewController = SearchViewController(reactor: searchReactor, locationManager: locationManger)
        
        searchReactor.readyToCreateGather
            .asDriver(onErrorJustReturn: ("", CLLocation.init()))
            .drive(with: self,
                   onNext: { this, data in
                let address = data.0
                let location = data.1
                this.pushCreateGatherViewController(address, location)
            })
            .disposed(by:disposeBag)
        
        searchReactor.readyToSearchGather
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushSearchGatherViewController()
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func pushSearchGatherViewController() {
        let gatherRepository = GatherRepository(networkManager: NetworkManager.shared)
        let searchGatherReactor = SearchGatherReactor(gatherRepository: gatherRepository)
        let searchGathreViewController = SearchGatherViewController(reactor: searchGatherReactor, locationManager: locationManger)
        
        //Do Something
        
        navigationController.pushViewController(searchGathreViewController, animated: true)
        
    }
    
    func pushCreateGatherViewController(_ address: String, _ location: CLLocation) {
        let networkManager = NetworkManager.shared
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let createGatherRepository = CreateGatherRepository(networkManager: networkManager)
        let createGatherReactor = CreateGatherReactor(location: (address, location), createGatherRepository: createGatherRepository, keychainUseCase: keychainUseCase)
        let createGatherViewController = CreateGatherViewController(reactor: createGatherReactor)
        
        createGatherReactor.readyToProceedSearchBreed
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                let reactor = SearchBreedReactor(parent: .Gather)
                let viewController = SearchBreedViewController(reactor: reactor)
                viewController.delegate = createGatherViewController
                this.pushSearchBreedViewController(viewController)
            })
            .disposed(by: disposeBag)
        
        createGatherReactor.readyToProceedMap
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                self.navigationController.popViewController(animated: true)
                self.start()
            })
            .disposed(by: disposeBag)
        
        
        navigationController.pushViewController(createGatherViewController, animated: true)
    }
    
    func pushSearchBreedViewController(_ viewController: SearchBreedViewController) {
        viewController.reactor?.readyToRegisterBreed
            .asDriver(onErrorJustReturn: [])
            .drive(with: self,
                   onNext: { this, breed in
                viewController.delegate?.sendData(data: breed)
                self.navigationController.popViewController(animated: true)
            })
            .disposed(by: disposeBag)


        navigationController.pushViewController(viewController, animated: true)
    }
}
