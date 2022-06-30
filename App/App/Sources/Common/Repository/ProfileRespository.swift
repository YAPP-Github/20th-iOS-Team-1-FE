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
    
    internal func requestProfileInfo(nickname: String) -> Single<ProfileInfo> {
        return Single.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard let url = URL(string: APIConstants.BASE_URL + APIConstants.GET_MY_PAGE + "\(nickname)") else {
                return Disposables.create()
            }
                        
            let keychain = KeychainQueryRequester()
            let keychainProvider = KeychainProvider(keyChain: keychain)
            guard let Token = try? keychainProvider.read(service: KeychainService.apple, account: KeychainAccount.accessToken) else {
                print("토큰이 존재하지 않습니다.")
                return Disposables.create()
            }
            let accessToken = "Bearer " + (String(data: Token, encoding: .utf8) ?? "")

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

}
