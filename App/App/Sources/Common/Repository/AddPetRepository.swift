//
//  AddPetRepository.swift
//  App
//
//  Created by 김나희 on 7/12/22.
//

import Foundation

import RxSwift

final class AddPetRepository: AddPetRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func addPet(pet: PetRequestInfo, accessToken: Data) -> Single<Void> {
        return Single<Void>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            guard let url = URL(string: APIConstants.BaseURL + APIConstants.Pet) else {
                return Disposables.create()
            }
            
            let boundary = NetworkManager.shared.generateBoundaryString()
            let accessToken = String(decoding: accessToken, as: UTF8.self).makePrefixBearer()
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let httpBody = NSMutableData()
            
            let formFields: [String: String?] = ["name": pet.name,
                                             "year": String(pet.year ?? 0),
                                             "month": String(pet.month ?? 0),
                                             "breed": pet.breed,
                                             "sex": pet.sex,
                                             "neutering": String(pet.neutering ?? false),
                                             "sizeType": pet.sizeType,
                                             "tags": pet.tags?.joined(separator: ",")]

            for (key, value) in formFields {
                httpBody.appendString(NetworkManager.shared.convertFormField(named: key, value: (value ?? "") , using: boundary))
            }

            httpBody.append(NetworkManager.shared.convertFileData(fieldName: "imageFile",
                                            fileName: "[PROXY]",
                                            mimeType: "image/jpg",
                                            fileData:  pet.imageFile ?? Data(),
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
