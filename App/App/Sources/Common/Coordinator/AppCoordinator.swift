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
    private let disposeBag = DisposeBag()
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var isLoggedIn: Bool
    
    init(window: UIWindow?, isLoggedIn: Bool) {
        self.window = window
        self.isLoggedIn = isLoggedIn
    }
    
    func start() {
        if isLoggedIn {
            moveToTabBar()
        } else {
            moveToAuth()
        }
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
        isLoggedIn = true
        childCoordinators.removeAll()
        moveToTabBar()
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func switchToAuth() {
        isLoggedIn = false 
        childCoordinators.removeAll()
        moveToAuth()
    }
}
