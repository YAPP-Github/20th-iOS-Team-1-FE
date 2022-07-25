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
        let createGatherReactor = CreateGatherReactor(createGatherRepository: createGatherRepository, keychainUseCase: keychainUseCase)
        let createGathreViewController = CreateGatherViewController(reactor: createGatherReactor)
        createGatherReactor.initialState.address = address
        createGathreViewController.createGatherView.addressTextField.text = address
        
        navigationController.pushViewController(createGathreViewController, animated: true)
    }
}
