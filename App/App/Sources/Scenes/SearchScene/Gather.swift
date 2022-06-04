//
//  Gather.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import Foundation

struct Gather: Codable {
    private let id: Int
    private let type: GatherCategory
    private let latitude: Double
    private let longitude: Double
}
