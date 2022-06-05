//
//  Gather.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import Foundation

struct Gather: Codable {
    private let id: Int
    private let latitude: Double
    private let longitude: Double
    private let type: GatherCategory
}

extension Gather {
    internal static var mock: Self {
        // 서울역
        return .init(
            id: 0,
            latitude: 37.555797,
            longitude: 126.973125,
            type: .walk
        )
    }
}
