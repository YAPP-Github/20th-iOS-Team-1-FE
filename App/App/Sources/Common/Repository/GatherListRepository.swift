//
//  GatherListRepository.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

import RxSwift

final class GatherListRepository: GatherListRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestGatherList(club: Int) -> Single<GatherListInfo> {
        let cursorQuery = URLQueryItem(name: "cursor-id", value: "2")
        var conditionQuery: URLQueryItem
        switch club {
        case 0:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_PARTICIPATING")
        case 1:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_LEADER")
        case 2:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_PARTICIPATED_AND_EXCEED")
        default:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_PARTICIPATING")
        }
        
        return Single.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let url = APIConstants.BaseURL + APIConstants.GetGatherList
            guard var urlComponents = URLComponents(string: url) else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = [cursorQuery, conditionQuery]
            
            let keychain = KeychainQueryRequester()
            let keychainProvider = KeychainProvider(keyChain: keychain)
            guard let Token = try? keychainProvider.read(service: KeychainService.apple, account: KeychainAccount.accessToken) else {
                print("토큰이 존재하지 않습니다.")
                return Disposables.create()
            }
            let accessToken = "Bearer " + (String(data: Token, encoding: .utf8) ?? "")
            
            var urlRequest = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: APIConstants.BaseURL))
            urlRequest.httpMethod = HTTPMethod.get
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let response: Single<GatherListResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let dto):
                    let data = dto.toDomain()
                    observer(.success(data))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

}
