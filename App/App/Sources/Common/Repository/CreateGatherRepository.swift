//
//  CreateGatherRepository.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import Foundation

import RxSwift

final class CreateGatherRepository: CreateGatherRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func createGather(accessToken: Data, club: ClubInfo) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = CreateClubRequestDTO(clubInfo: club)
            
            print(dto)
            let data = try? JSONEncoder().encode(dto)
            print(String(decoding: data!, as: UTF8.self))

            guard let url = URL(string: APIConstants.Club.create),
                  let data = try? JSONEncoder().encode(dto) else {
                return Disposables.create()
            }

            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpBody = data
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
