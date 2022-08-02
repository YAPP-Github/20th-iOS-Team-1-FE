//
//  EditProfileRepository.swift
//  App
//
//  Created by 김나희 on 7/14/22.
//

import Foundation

import RxSwift

final class EditProfileRepository: EditProfileRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func editProfile(introduction: String, accessToken: Data) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
        
            guard let url = URL(string: APIConstants.BaseURL + APIConstants.account) else {
                return Disposables.create()
            }
            
            let boundary = NetworkManager.shared.generateBoundaryString()
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.patch
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let formFields: [String: String] = ["selfIntroduction": introduction]
            let httpBody = NSMutableData()

            for (key, value) in formFields {
                httpBody.appendString(NetworkManager.shared.convertFormField(named: key, value: value, using: boundary))
            }

            httpBody.appendString("--\(boundary)--")

            urlRequest.httpBody = httpBody as Data

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
