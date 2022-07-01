//
//  SceneCoordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

protocol SceneCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}
