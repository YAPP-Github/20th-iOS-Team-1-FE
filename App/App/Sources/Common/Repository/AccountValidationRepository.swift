//
//  AccountValidationRepository.swift
//  App
//
//  Created by Hani on 2022/06/24.
//

import Foundation

import RxSwift

final class AccountValidationRepository: AccountValidationRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func validateDuplicationAndLength(nickname: String, accessToken: Data) -> Single<AccountValidation> {
        return Single.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard let url = URL(string: "https://yapp-togather.com/api/accounts/validate-nickname/\(nickname)") else {
                return Disposables.create()
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpBody = accessToken
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let response: Single<AccountValidationResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
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
