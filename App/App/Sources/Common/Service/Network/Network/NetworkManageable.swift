//
//  NetworkManageable.swift
//  App
//
//  Created by Hani on 2022/06/07.
//

import Foundation

import RxSwift

protocol NetworkManageable {
    func requestDataTask(with request: URLRequest) -> Single<Data>
}
