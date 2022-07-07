//
//  NetworkManageable.swift
//  App
//
//  Created by Hani on 2022/06/07.
//

import Foundation

import RxSwift

protocol NetworkManageable {
    func requestDataTask<T: Decodable>(with request: URLRequest) -> Single<T>
    func requestUploadTask<T: Decodable>(with request: URLRequest, data: Data) -> Single<T>
}
