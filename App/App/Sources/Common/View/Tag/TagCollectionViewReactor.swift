//
//  TagCollectionViewReactor.swift
//  App
//
//  Created by 김나희 on 7/6/22.
//

import UIKit

import ReactorKit

final class TagCollectionViewReactor: Reactor {
    
    typealias Action = NoAction
    
    let initialState: [String]
    
    init(state: [String]) {
        self.initialState = state
    }
}
