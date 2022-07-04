//
//  GatherRepository.swift
//  App
//
//  Created by 유한준 on 2022/07/01.
//

import CoreLocation
import Foundation

import RxSwift

protocol GatherRepositoryInterface {
    func requestGatherConfigurationForAnnotation(
        topLeftCoordinate: CLLocationCoordinate2D,
        bottomRightCoordinate: CLLocationCoordinate2D
    ) -> Single<[GatherConfigurationForAnnotation]>
    
    func requsetGatherConfigurationForBottomSheet(
        gatherID: Int,
        userLocation: CLLocation
    ) -> Single<GatherConfigurationForSheet>
}

struct GatherConfigurationForAnnotationRequestDTO: Codable {
    private var upperLeftLatitude: Double
    private var upperLeftLongitude: Double
    private var bottomRightLatitude: Double
    private var bottomRightLongitude: Double
    internal var toQueryString: String {
        "upperLeftLatitude=\(upperLeftLatitude)&upperLeftLongitude=\(upperLeftLongitude)&bottomRightLatitude=\(bottomRightLatitude)&bottomRightLongitude=\(bottomRightLongitude)"
    }
    
    init(
        topLeftCoordinate: CLLocationCoordinate2D,
        bottomRightCoordinate: CLLocationCoordinate2D
    ) {
        self.upperLeftLatitude = Double(topLeftCoordinate.latitude)
        self.upperLeftLongitude = Double(topLeftCoordinate.longitude)
        self.bottomRightLatitude = Double(bottomRightCoordinate.latitude)
        self.bottomRightLongitude = Double(bottomRightCoordinate.longitude)
    }
}

struct GatherConfigurationForSheetRequestDTO: Codable {
    private var id: Int
    private var userLatitude: Double
    private var userLongitude: Double
    internal var toQueryString: String {
        "\(id)?userLatitude=\(userLatitude)&userLongitude=\(userLongitude)"
    }
    
    init(id: Int, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.userLatitude = coordinate.latitude
        self.userLongitude = coordinate.longitude
    }
}

final class GatherRepository: GatherRepositoryInterface {
    private let networkManager: NetworkManageable
    private let disposeBag = DisposeBag()
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    internal func requestGatherConfigurationForAnnotation(
        topLeftCoordinate: CLLocationCoordinate2D,
        bottomRightCoordinate: CLLocationCoordinate2D
    ) -> Single<[GatherConfigurationForAnnotation]> {
        return Single<[GatherConfigurationForAnnotation]>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = GatherConfigurationForAnnotationRequestDTO(
                topLeftCoordinate: topLeftCoordinate,
                bottomRightCoordinate: bottomRightCoordinate
            )
            
            guard let url = URL(string: "https://yapp-togather.com/api/clubs/search/range?\(dto.toQueryString)")
            else {
                return Disposables.create()
            }
            let keychain = KeychainQueryRequester()
            let keychainProvider = KeychainProvider(keyChain: keychain)
            guard let Token = try? keychainProvider.read(
                service: KeychainService.apple,
                account: KeychainAccount.accessToken
            ) else {
                print("토큰이 존재하지 않습니다.")
                return Disposables.create()
            }
            let accessToken = "Bearer " + (String(data: Token, encoding: .utf8) ?? "")
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            
            let response: Single<[GatherConfigurationForAnnotation]> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let gatherConfigurationForAnnotations):
                    observer(.success(gatherConfigurationForAnnotations))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    internal func requsetGatherConfigurationForBottomSheet(
        gatherID: Int,
        userLocation: CLLocation
    ) -> Single<GatherConfigurationForSheet> {
        return Single<GatherConfigurationForSheet>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = GatherConfigurationForSheetRequestDTO(
                id: gatherID,
                coordinate: userLocation.coordinate
            )
            
            guard let url = URL(string: "https://yapp-togather.com/api/clubs/search/simple/\(dto.toQueryString)")
            else {
                return Disposables.create()
            }
            
            let keychain = KeychainQueryRequester()
            let keychainProvider = KeychainProvider(keyChain: keychain)
            guard let Token = try? keychainProvider.read(
                service: KeychainService.apple,
                account: KeychainAccount.accessToken
            ) else {
                print("토큰이 존재하지 않습니다.")
                return Disposables.create()
            }
            let accessToken = "Bearer " + (String(data: Token, encoding: .utf8) ?? "")
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            
            let response: Single<GatherConfigurationForSheetResponseDTO> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let GatherConfigurationForSheetResponseDTO):
                    observer(.success(GatherConfigurationForSheetResponseDTO.toDomain()))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }

    }
}
