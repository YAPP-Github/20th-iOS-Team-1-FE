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
    
    internal func requestUploadTask<T: Decodable>(with request: URLRequest, data: Data) -> Single<T> {
        return Single<T>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let task = self.session.uploadTask(with: request, from: data) { data, response, error in
                if let error = error {
                    observer(.failure(NetworkError.transportError(error)))
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                    observer(.failure(NetworkError.serverError(statusCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    observer(.failure(NetworkError.noDataError))
                    return
                }
                
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    observer(.failure(NetworkError.decodeError))
                    return
                }
                
                observer(.success(decodedData))
            }
                
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    internal func requestDataTask<T: Decodable>(with request: URLRequest) -> Single<T> {
        return Single<T>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.failure(NetworkError.transportError(error)))
                    return
                }
                if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                    observer(.failure(NetworkError.serverError(statusCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    observer(.failure(NetworkError.noDataError))
                    return
                }
                
            
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    observer(.failure(NetworkError.decodeError))
                    return
                }
                
                observer(.success(decodedData))
 
            }
                
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
}
