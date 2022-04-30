//
//  SceneCoordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

protocol SceneCoordinator: Coordinator {
    var parentCoordinator: SceneCoordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func remove(childCoordinator: SceneCoordinator)
}

extension SceneCoordinator {
    func remove(childCoordinator: SceneCoordinator) {
        childCoordinators.removeAll(where: { $0 === childCoordinator })
    }
}
