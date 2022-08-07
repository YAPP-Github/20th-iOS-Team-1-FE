//
//  SearchReactor.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import CoreLocation
import Foundation

import ReactorKit
import RxSwift

final class SearchReactor: Reactor {
    enum Action {
        case mapViewVisibleRegionDidChanged(CLLocationCoordinate2D, CLLocationCoordinate2D)
        case annotationViewDidSelect(Int, CLLocation)
        case searchButtonTapped
        case bottomSheetTapped
        case createGatherButtonTapped(String, CLLocation)
        case viewWillAppear
    }
    
    enum Mutation {
        case setVisibleCoordinate(CLLocationCoordinate2D)
        case setMapViewAnnotation([GatherConfigurationForAnnotation])
        case loadingAnnotation(Bool)
        case setSelectedGather(GatherConfigurationForSheet)
        case loadingBottomSheet(Bool)
        case activateCreateGatherButton(Bool)
    }
    
    struct State {
        var visibleCoordinate: Coordinate
        var currentSpan: Double = 0.005
        var annotations: [GatherConfigurationForAnnotation] = []
        var selectedGather: GatherConfigurationForSheet?
        var isAnnotationLoading: Bool = true
        var isBottomSheetLoading: Bool = true
        var isCreateGatherButtonEnabled: Bool = false
        
    }
    
    internal let initialState: State
    private let disposeBag = DisposeBag()
    private let gatherRepository: GatherRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let profileMainRepository: ProfileMainRepositoryInterface
    internal var readyToSearchGather = PublishSubject<Void>()
    internal var readyToCreateGather = PublishSubject<(String, CLLocation)>()
    internal var readyToDetailGather = PublishSubject<Int>()

    init(gatherRepository: GatherRepositoryInterface, keychainUseCase: KeychainUseCaseInterface, profileMainRepository: ProfileMainRepositoryInterface, visibleCoordinate: Coordinate = .seoulCityHall) {
        self.initialState = State(visibleCoordinate: visibleCoordinate)
        self.gatherRepository = gatherRepository
        self.keychainUseCase = keychainUseCase
        self.profileMainRepository = profileMainRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case let .mapViewVisibleRegionDidChanged(topLeftCoordinate, rightBottomCoordinate):
            return searchMapViewAnnotation(
                topLeftCoordinate: topLeftCoordinate,
                rightBottomCoordinate: rightBottomCoordinate
            )
            
        case .searchButtonTapped:
            readyToSearchGather.onNext(())
            return Observable.empty()
            
        case let .annotationViewDidSelect(gatherID, location):
            return requsetGatherConfigurationForSheet(
                gatherID: gatherID,
                userLocation: location
            )
            
        case .bottomSheetTapped:
            readyToDetailGather.onNext(currentState.selectedGather?.clubID ?? 0)
            return Observable.empty()
        
        case .createGatherButtonTapped(let address, let location):
            readyToCreateGather.onNext((address, location))
            return Observable.empty()
            
        case .viewWillAppear:
            return getProfileInfo(nickname: nil)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .setVisibleCoordinate(let newCoordinate):
            newState.visibleCoordinate = Coordinate(
                latitude: newCoordinate.latitude,
                longitude: newCoordinate.longitude
            )
            
        case .setMapViewAnnotation(let gatherConfigurationsForAnnotation):
            newState.annotations = gatherConfigurationsForAnnotation
            
        case .loadingAnnotation(let isSuccess):
            newState.isAnnotationLoading = isSuccess
            
        case .setSelectedGather(let gatherConfigurationForSheet):
            newState.selectedGather = gatherConfigurationForSheet
            
        case .loadingBottomSheet(let isSuccess):
            newState.isBottomSheetLoading = isSuccess
        case .activateCreateGatherButton(let enabled):
            newState.isCreateGatherButtonEnabled = enabled
        }
        
        return newState
    }
    private func getProfileInfo(nickname: String?) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.profileMainRepository.requestProfileInfo(accessToken: token, nickname: nil)
                        .subscribe { result in
                            switch result {
                            case .success(let profileInfo):
                                guard let accountInfo = profileInfo.accountInfo,
                                      let petInfos = profileInfo.petInfos,
                                      !petInfos.isEmpty else {
                                    observer.onNext(Mutation.activateCreateGatherButton(false))
                                    return
                                }
                                observer.onNext(Mutation.activateCreateGatherButton(true))
                            case .failure(let error):
                                observer.onNext(Mutation.activateCreateGatherButton(false))
                           }
                        }.disposed(by: self.disposeBag)
                    },
                   onFailure: { _,_ in
                    observer.onNext(Mutation.activateCreateGatherButton(false))
                      return
                   })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    private func searchMapViewAnnotation(
        topLeftCoordinate: CLLocationCoordinate2D,
        rightBottomCoordinate: CLLocationCoordinate2D
    ) -> Observable<Mutation> {
        return Observable.create { [unowned self] observer in
            self.gatherRepository
                .requestGatherConfigurationForAnnotation(
                    topLeftCoordinate: topLeftCoordinate,
                    bottomRightCoordinate: rightBottomCoordinate
                )
                .subscribe { result in
                    switch result {
                    case .success(let gatherConfigrationsForAnnotations):
                        observer.onNext(
                            Mutation.setMapViewAnnotation(gatherConfigrationsForAnnotations)
                        )
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                        observer.onNext(Mutation.loadingAnnotation(false))
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    
    private func requsetGatherConfigurationForSheet(
        gatherID: Int,
        userLocation: CLLocation
    ) -> Observable<Mutation> {
        return Observable.create { [unowned self] observer in
            self.gatherRepository
                .requsetGatherConfigurationForBottomSheet(
                    gatherID: gatherID,
                    userLocation: userLocation
                )
                .subscribe { result in
                    switch result {
                    case .success(let gatherConfigurationForSheet):
                        observer.onNext(
                            Mutation.setSelectedGather(gatherConfigurationForSheet)
                        )
                    case .failure(let error):
                        print("RESULT FAILURE: ", error.localizedDescription)
                        observer.onNext(Mutation.loadingBottomSheet(false))
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

}
