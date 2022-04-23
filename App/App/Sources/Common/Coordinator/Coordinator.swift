//
//  Coordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
