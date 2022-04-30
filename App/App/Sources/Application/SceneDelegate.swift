//
//  SceneDelegate.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var tabCoordinator: TabCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        
        tabCoordinator = TabCoordinator(window: window)
        tabCoordinator?.start()
    }
}

