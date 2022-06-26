//
//  AppleLoginRepository.swift
//  App
//
//  Created by Hani on 2022/06/16.
//

import Foundation

import RxSwift

final class AppleLoginRepository: AppleLoginRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestAppleLogin(appleCredential: AppleCredential) -> Single<SignInResult> {
        return Single.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = AppleCredentialRequestDTO(appleCredential: appleCredential)
            print(dto.idToken)
            guard let url = URL(string: "https://yapp-togather.com/auth/apple"),
                  let data = try? JSONEncoder().encode(dto) else {
                return Disposables.create()
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpBody = data
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            let response: Single<SignInResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
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
