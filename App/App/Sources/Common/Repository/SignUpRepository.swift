//
//  SignUpRepository.swift
//  App
//
//  Created by Hani on 2022/06/27.
//

import Foundation

import RxSwift 

final class SignUpRepository: SignUpRepositoryInterface {
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
            
            guard let url = URL(string: APIConstants.Account.signUp) else {
                return Disposables.create()
            }
            
            let boundary = NetworkManager.shared.generateBoundaryString()
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let formFields: [String: String] = ["nickname": user.nickName ?? "",
                                                "age": String(user.age ?? 0),
                                                "sex": user.sex ?? "MAN",
                                                "city": user.bigCity ?? "서울시",
                                                "detail": user.smallCity ?? "강남구"]
            
            let httpBody = NSMutableData()

            for (key, value) in formFields {
                httpBody.appendString(NetworkManager.shared.convertFormField(named: key, value: value, using: boundary))
            }

            httpBody.append(NetworkManager.shared.convertFileData(fieldName: "imageFile",
                                            fileName: "[PROXY]",
                                            mimeType: "image/jpg",
                                            fileData:  user.profileImageData ?? Data(),
                                            using: boundary))

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
