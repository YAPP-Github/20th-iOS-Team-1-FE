//
//  AppCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

import RxSwift

enum Start {
    case tapBar
    case login
    case agreement
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow?
    private let disposeBag = DisposeBag()
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var startFrom: Start
    
    init(window: UIWindow?, start: Start) {
        self.window = window
        self.startFrom = start
    }
    
    func start() {
        switch startFrom {
        case .tapBar:
            moveToTabBar()
        case .login:
            moveToAuth()
        case .agreement:
            moveToAgreement()
        }
    }
    
    private func moveToAgreement() {
        let authCoordinator = AuthCoordinator(window: window)
        childCoordinators.append(authCoordinator)
        authCoordinator.delegate = self
        authCoordinator.startAgreement()
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
        startFrom = .tapBar
        childCoordinators.removeAll()
        moveToTabBar()
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func switchToAuth() {
        startFrom = .login
        childCoordinators.removeAll()
        moveToAuth()
    }
    
    func switchToAgreement() {
        startFrom = .agreement
        childCoordinators.removeAll()
        moveToAgreement()
    }
}
