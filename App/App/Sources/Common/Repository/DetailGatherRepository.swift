//
//  DetailGatherRepository.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

import RxSwift

final class DetailGatherRepository: DetailGatherRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestDetailGather(accessToken: Data, clubID: Int) -> Single<ClubFindDetail> {
        return Single<ClubFindDetail>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard let urlComponents = URLComponents(string: APIConstants.Club.detail + "/\(clubID)") else {
                return Disposables.create()
            }
            
            guard let url = urlComponents.url else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<ClubFIndDetailResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let dto):
                    let domain = dto.toDomain()
                    observer(.success(domain))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    internal func participateGather(accessToken: Data, clubID: Int) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Club.participate + "/\(clubID)") else {
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
    
    internal func deleteComment(accessToken: Data, commentID: String) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Comment.delete + "/\(commentID)") else {
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
    
    internal func reportClub(accessToken: Data, clubID: Int) -> Single<Bool> {
        return Single<Bool>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Report.club + "/\(clubID)") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<Bool> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let isSuccess):
                    observer(.success(isSuccess))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    internal func deleteClub(accessToken: Data, clubID: Int) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Club.delete + "/\(clubID)") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.delete
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
    
    internal func leaveClub(accessToken: Data, clubID: Int) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Club.leave + "/\(clubID)") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.delete
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
    
    internal func reportComment(accessToken: Data, commentID: Int) -> Single<Bool> {
        return Single<Bool>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.Report.comment + "/\(commentID)") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<Bool> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let isSuccess):
                    observer(.success(isSuccess))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    internal func addComment(accessToken: Data, comment: CommentRequest) -> Single<ClubFindDetail> {
        return Single<ClubFindDetail>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = CommentRequestDTO(comment: comment)
            
            guard let url = URL(string: APIConstants.Comment.post),
                  let data = try? JSONEncoder().encode(dto) else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.httpBody = data
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<ClubFIndDetailResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let dto):
                    let domain = dto.toDomain()
                    observer(.success(domain))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
