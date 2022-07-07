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
            
            guard let dto = SignUpAccountDTO(user: user),
                  let url = URL(string: "https://yapp-togather.com/api/accounts/sign-up"),
                  let data = try? JSONEncoder().encode(dto) else {
                return Disposables.create()
            }
            
            let boundary = UUID().uuidString
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()
            let requestData = self.createRequestBody(imageData: user.profileImageData!, boundary: boundary, attachmentKey: "ImageFile", fileName: "aa.png")
                  
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.httpBody = requestData
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
         //   urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
         urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//
//            var data1 = Data()
//
//              // Add the image data to the raw http request data
//              data1.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//
//            if let image = user.profileImageData {
//                data1.append("Content-Disposition: form-data; name=\"imageFile\"; filename=\"aa.png\"\r\n".data(using: .utf8)!)
//                data1.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//                data1.append(image)
//            }
//              data1.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
            
            
            let response: Single<Int> = self.networkManager.requestUploadTask(with: urlRequest, data: data)
            
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
    func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String) -> Data{
         let lineBreak = "\r\n"
         var requestBody = Data()

         requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
         requestBody.append("Content-Type: image/png\(lineBreak + lineBreak)" .data(using: .utf8)!) // you can change the type accordingly if you want to
         requestBody.append(imageData)
         requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)

         return requestBody
     }
}
