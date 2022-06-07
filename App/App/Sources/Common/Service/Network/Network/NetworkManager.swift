//
//  NetworkManager.swift
//  App
//
//  Created by Hani on 2022/06/06.
//

import Foundation

import RxSwift

final class NetworkManager: NetworkManageable {
    internal static let shared = NetworkManager()
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    internal func requestDataTask(with request: URLRequest) -> Single<Data> {
        return Single.create { [weak self] single in
            self?.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(NetworkError.transportError(error)))
                    return
                }
               
                if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                    single(.failure(NetworkError.serverError(statusCode: response.statusCode)))
                    return
                }
               
                guard let data = data else {
                    single(.failure(NetworkError.noDataError))
                    return
                }
               
                single(.success(data))
 
            }.resume()
            
            return Disposables.create()
        }
    }
}
