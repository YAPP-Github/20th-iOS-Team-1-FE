//
//  MyPageRespository.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

import RxSwift

final class ProfileRespository: ProfileMainRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestProfileInfo(accessToken: Data, nickname: String? = nil) -> Single<ProfileInfo> {
        let query = [URLQueryItem(name: "nickname", value: nickname)]
        return Single<ProfileInfo>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard var urlComponents = URLComponents(string: APIConstants.BaseURL + APIConstants.GetMyPage) else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = query
            
            guard let url = urlComponents.url else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<ProfileResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
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
    
    func deletePet(accessToken: Data, id: Int) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.BaseURL + APIConstants.Pet + "/\(id)") else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.delete
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
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
