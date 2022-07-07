//
//  DetailGatherRepository.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

import RxSwift

final class DetailGatherRepository {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func signUp(user: UserAccount, accessToken: Data) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard let dto = SignUpAccountDTO(user: user),
                  let url = URL(string: "https://yapp-togather.com/api/accounts/sign-up"),
                  let data = try? JSONEncoder().encode(dto) else {
                return Disposables.create()
            }
            
            let boundary = UUID().uuidString
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.httpBody = data
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            
            let response: Single<ClubInfosResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
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
