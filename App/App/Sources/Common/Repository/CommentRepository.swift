//
//  CommentRepository.swift
//  App
//
//  Created by Hani on 2022/07/11.
//

import Foundation

import RxSwift

final class CommentRepository: CommentRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func deleteComment(accessToken: Data, commentID: String) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.BaseURL + APIConstants.comment + "/\(commentID))") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<Int> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(_):
                    observer(.success(()))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
