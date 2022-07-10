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
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO: KeyChainProvider
        let gatherRepository = GatherRepository(networkManager: NetworkManager.shared)
        let searchReactor = SearchReactor(gatherRepository: gatherRepository)
        let locationManger = CLLocationManager()
        let viewController = SearchViewController(reactor: searchReactor, locationManager: locationManger)
        
        searchReactor.readyToCreateGather
            .asDriver(onErrorJustReturn: ("", CLLocationCoordinate2D.init()))
            .drive(with: self,
                   onNext: { this, _ in
                this.pushCreateGatherViewController()
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
        let searchGathreViewController = SearchGatherViewController(reactor: searchGatherReactor)
        
        //Do Something
        
        navigationController.pushViewController(searchGathreViewController, animated: true)
        
    }
    
    func pushCreateGatherViewController() {
        // 여행 생성 페이지
    }
}
