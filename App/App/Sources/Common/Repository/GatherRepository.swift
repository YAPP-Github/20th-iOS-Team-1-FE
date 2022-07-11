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
    
    func requestGatherSearchResult(
        keyword: String?,
        category: GatherCategory?,
        eligibleBreed: String?,
        sex: OwnerSex?,
        minimumParticipant: Int?,
        maximumParticipant: Int?,
        page: Int?,
        startLatitude: CLLocationDegrees?,
        startLongitude: CLLocationDegrees?,
        status: ClubStatus?
    ) -> Single<[GatherConfigurationForSheet]>
}

struct GatherConfigurationForAnnotationRequestDTO: Codable {
    private var upperLeftLatitude: Double
    private var upperLeftLongitude: Double
    private var bottomRightLatitude: Double
    private var bottomRightLongitude: Double
    internal var queryItems: [URLQueryItem] {
        var queries: [URLQueryItem] = []
        
        queries.append(URLQueryItem(name: "upperLeftLatitude", value: String(upperLeftLatitude)))
        queries.append(URLQueryItem(name: "upperLeftLongitude", value: String(upperLeftLongitude)))
        queries.append(URLQueryItem(name: "bottomRightLatitude", value: String(bottomRightLatitude)))
        queries.append(URLQueryItem(name: "bottomRightLongitude", value: String(bottomRightLongitude)))
        
        return queries
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
    internal var id: Int
    private var userLatitude: Double
    private var userLongitude: Double
    internal var queryItems: [URLQueryItem] {
        var queries: [URLQueryItem] = []
        
        queries.append(URLQueryItem(name: "userLatitude", value: String(userLatitude)))
        queries.append(URLQueryItem(name: "userLongitude", value: String(userLongitude)))
        
        return queries

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
            
            let url = APIConstants.BaseURL + APIConstants.GetSearch + APIConstants.Range
            
            guard var urlComponents = URLComponents(string: url)
            else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = dto.queryItems
            
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
            
            guard let url = urlComponents.url
            else {
                return Disposables.create()
            }
            
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
            
            let url = APIConstants.BaseURL + APIConstants.GetSearch + APIConstants.Simple + "/\(dto.id)"
            
            guard var urlComponents = URLComponents(string: url)
            else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = dto.queryItems
            
            guard let url = urlComponents.url
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
                case .success(let gatherConfigurationForSheetResponseDTO):
                    observer(.success(gatherConfigurationForSheetResponseDTO.toDomain()))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func requestGatherSearchResult(keyword: String?, category: GatherCategory?, eligibleBreed: String?, sex: OwnerSex?, minimumParticipant: Int?, maximumParticipant: Int?, page: Int?, startLatitude: CLLocationDegrees?, startLongitude: CLLocationDegrees?, status: ClubStatus?) -> Single<[GatherConfigurationForSheet]> {
        return Single<[GatherConfigurationForSheet]>.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            let dto = GatherSearchRequestDTO(
                keyword: keyword,
                category: category,
                eligibleBreed: eligibleBreed,
                sex: sex,
                minimumParticipant: minimumParticipant,
                maximumParticipant: maximumParticipant,
                page: page,
                startLatitude: startLatitude,
                startLongitude: startLongitude,
                status: status
            )
            
            let url = APIConstants.BaseURL + APIConstants.GetSearch
            guard var urlComponents = URLComponents(string: url)
            else {
                return Disposables.create()
            }
            
            urlComponents.queryItems = dto.queryItems
            
            guard let url = urlComponents.url
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
            
            let response: Single<[GatherConfigurationForSheetResponseDTO]> = self.networkManager.requestDataTask(with: urlRequest)
            
            response.subscribe { result in
                switch result {
                case .success(let gatherConfigurationForSheetResponseDTOs ):
                    observer(.success(gatherConfigurationForSheetResponseDTOs.map { $0.toDomain()}))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }

}

struct GatherSearchRequestDTO: Codable {
    private var searchingWord: String?
    private var category: String?
    private var eligibleBreed: String?
    private var petSizeType: String?
    private var eligibleSex: String?
    private var participateMin: Int?
    private var participateMax: Int?
    private var page: Int?
    private var startLatitude: Double?
    private var startLongitude: Double?
    private var status: String?
    
    internal var queryItems: [URLQueryItem] {
        var queries: [URLQueryItem] = []
        
        if let searchingWord = searchingWord {
            queries.append(URLQueryItem(name: "searchingWord", value: searchingWord))
        }
        if let category = category {
            queries.append(URLQueryItem(name: "category", value: category))
        }
        if let eligibleBreed = eligibleBreed {
            queries.append(URLQueryItem(name: "eligibleBreed", value: eligibleBreed))
        }
        if let petSizeType = petSizeType {
            queries.append(URLQueryItem(name: "petSizeType", value: petSizeType))
        }
        if let eligibleSex = eligibleSex {
            queries.append(URLQueryItem(name: "eligibleSex", value: eligibleSex))
        }
        if let participateMin = participateMin {
            queries.append(URLQueryItem(name: "participateMin", value: String(participateMin)))
        }
        if let participateMax = participateMax {
            queries.append(URLQueryItem(name: "participateMax", value: String(participateMax)))
        }
        if let page = page {
            queries.append(URLQueryItem(name: "page", value: String(page)))
        }
        if let startLatitude = startLatitude {
            queries.append(URLQueryItem(name: "startLatitude", value: String(startLatitude)))
        }
        if let startLongitude = startLongitude {
            queries.append(URLQueryItem(name: "startLongitude", value: String(startLongitude)))
        }
        if let status = status {
            queries.append(URLQueryItem(name: "status", value: status))
        }
        
        return queries
    }
    
    init(
        keyword: String?,
        category: GatherCategory?,
        eligibleBreed: String?,
        sex: OwnerSex?,
        minimumParticipant: Int?,
        maximumParticipant: Int?,
        page: Int?,
        startLatitude: CLLocationDegrees?,
        startLongitude: CLLocationDegrees?,
        status: ClubStatus?
    ) {
        self.searchingWord = keyword
        self.category = category?.rawValue
        self.eligibleBreed = eligibleBreed
        self.eligibleSex = sex?.rawValue
        self.participateMin = minimumParticipant
        self.participateMax = maximumParticipant
        self.page = page
        self.startLatitude = startLatitude
        self.startLongitude = startLongitude
        self.status = status?.rawValue
    }
}
