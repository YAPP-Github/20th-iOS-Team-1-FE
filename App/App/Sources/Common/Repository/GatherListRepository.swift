//
//  GatherListRepository.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

import RxSwift

enum Gather: Int {
    case participating
    case host
    case past
}

final class GatherListRepository: GatherListRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestGatherList(lastID: String?, endDate: String?, gatherCondition: Gather, accessToken: Data) -> Single<GatherListInfo> {
        let cursorQuery = URLQueryItem(name: "cursor-id", value: lastID)
        let cursorEndDateQuery = URLQueryItem(name: "cursor-end-date", value: endDate)
        var conditionQuery: URLQueryItem
        switch gatherCondition {
        case .participating:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_PARTICIPATING")
        case .host:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_LEADER")
        case .past:
            conditionQuery = URLQueryItem(name: "condition", value: "I_AM_PARTICIPATED_AND_EXCEED")
        }
        
        return Single.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let url = APIConstants.Club.list
            guard var urlComponents = URLComponents(string: url) else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = [cursorQuery, cursorEndDateQuery, conditionQuery]
            
            guard let url = urlComponents.url else {
                return Disposables.create()
            }
            
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()
            var urlRequest = URLRequest(url: url)
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
