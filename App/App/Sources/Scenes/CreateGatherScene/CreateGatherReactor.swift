//
//  CreateGatherReactor.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift
import MapKit

final class CreateGatherReactor: Reactor {
    enum Action {
        case addressTextFieldDidEndEditing(String)
        case walkButtonDidTap
        case playgroundButtonDidTap
        case dogCafeButtonDidTap
        case dogRestaurantButtonDidTap
        case fairButtonDidTap
        case etcButtonDidTap
        case titleTextFieldDidEndEditing(String)
        case contentTextViewDidEndEditing(String)
        case startDateTextFieldDidEndEditing(String)
        case startTimeTextFieldDidEndEditing(String)
        case endDateTextFieldDidEndEditing(String)
        case endTimeTextFieldDidEndEditing(String)
        case numberOfPeopleTextFieldDidEndEditing(Int)
        case allGenderButtonDidTap
        case manButtonDidTap
        case womanButtonDidTap
        case smallPetButtonDidTap
        case middlePetButtonDidTap
        case largePetButtonDidTap
        case searchBarDidTap
        case updateBreeds([String])
        case createButtonDidTap
    }
    
    enum Mutation {
        case updateAddress(String)
        case selectWalk
        case selectPlayground
        case selectDogCafe
        case selectDogRestaurant
        case selectFair
        case selectEtc
        case updateTitle(String)
        case updateContent(String)
        case updateStartDate(String)
        case updateStartTime(String)
        case updateEndDate(String)
        case updateEndTime(String)
        case updateNumberOfPeople(Int)
        case selectAllGender
        case selectMan
        case selectWoman
        case selectSmall
        case selectMiddle
        case selectLarge
        case updateBreeds([String])
    }
    
    struct State {
        var clubInfo: ClubInfo
        var isWalkButtonSelected = false
        var isPlaygroundButtonSelected = false
        var isDogCafeButtonSelected = false
        var isDogRestaurantButtonSelected = false
        var isFairButtonSelected = false
        var isEtcButtonSelected = false
        var isAllGenderSelected = false
        var isManSelected = false
        var isWomanSelected = false
        var isSmallSelected = false
        var isMiddleSelected = false
        var isLargeSelected = false
        var isCreateButtonEnabled = false
    }
    
    let initialState: State
    private let createGatherRepository: CreateGatherRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    internal var readyToProceedSearchBreed = PublishSubject<Void>()
    internal var readyToProceedMap = PublishSubject<Void>()

    init(location: (String, CLLocation), createGatherRepository: CreateGatherRepository, keychainUseCase: KeychainUseCaseInterface) {
        self.createGatherRepository = createGatherRepository
        self.keychainUseCase = keychainUseCase
        
        let address = location.0
        let latitude = location.1.coordinate.latitude
        let longitude = location.1.coordinate.longitude
        initialState = State(clubInfo: ClubInfo(meetingPlace: address, latitude: latitude, longitude: longitude))
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .addressTextFieldDidEndEditing(let address):
            return Observable.just(.updateAddress(address))
        case .walkButtonDidTap:
            return Observable.just(.selectWalk)
        case .playgroundButtonDidTap:
            return Observable.just(.selectPlayground)
        case .dogCafeButtonDidTap:
            return Observable.just(.selectDogCafe)
        case .dogRestaurantButtonDidTap:
            return Observable.just(.selectDogRestaurant)
        case .fairButtonDidTap:
            return Observable.just(.selectFair)
        case .etcButtonDidTap:
            return Observable.just(.selectEtc)
        case .titleTextFieldDidEndEditing(let title):
            return Observable.just(.updateTitle(title))
        case .contentTextViewDidEndEditing(let description):
            return Observable.just(.updateContent(description))
        case .startDateTextFieldDidEndEditing(let date):
            return Observable.just(.updateStartDate(date))
        case .startTimeTextFieldDidEndEditing(let time):
            return Observable.just(.updateStartTime(time))
        case .endDateTextFieldDidEndEditing(let date):
            return Observable.just(.updateEndDate(date))
        case .endTimeTextFieldDidEndEditing(let time):
            return Observable.just(.updateEndTime(time))
        case .numberOfPeopleTextFieldDidEndEditing(let num):
            return Observable.just(.updateNumberOfPeople(num))
        case .allGenderButtonDidTap:
            return Observable.just(.selectAllGender)
        case .manButtonDidTap:
            return Observable.just(.selectMan)
        case .womanButtonDidTap:
            return Observable.just(.selectWoman)
        case .smallPetButtonDidTap:
            return Observable.just(.selectSmall)
        case .middlePetButtonDidTap:
            return Observable.just(.selectMiddle)
        case .largePetButtonDidTap:
            return Observable.just(.selectLarge)
        case .searchBarDidTap:
            readyToProceedSearchBreed.onNext(())
            return Observable.empty()
        case .updateBreeds(let breeds):
            return Observable.just(.updateBreeds(breeds))
        case .createButtonDidTap:
            createGather(currentState.clubInfo)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateAddress(let address):
            newState.clubInfo.meetingPlace = address
        case .selectWalk:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .walk
            newState.isWalkButtonSelected = true
        case .selectPlayground:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .playground
            newState.isPlaygroundButtonSelected = true
        case .selectDogCafe:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .dogCafe
            newState.isDogCafeButtonSelected = true
        case .selectDogRestaurant:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .dogRestaurant
            newState.isDogRestaurantButtonSelected = true
        case .selectFair:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .exhibition
            newState.isFairButtonSelected = true
        case .selectEtc:
            newState = categoryStateReset(newState)
            newState.clubInfo.category = .etc
            newState.isEtcButtonSelected = true
        case .updateTitle(let title):
            newState.clubInfo.title = title
        case .updateContent(let description):
            newState.clubInfo.description = description
        case .updateStartDate(let date):
            newState.clubInfo.startDate = date
        case .updateStartTime(let time):
            newState.clubInfo.startTime = time
        case .updateEndDate(let date):
            newState.clubInfo.endDate = date
        case .updateEndTime(let time):
            newState.clubInfo.endTime = time
        case .updateNumberOfPeople(let num):
            newState.clubInfo.maximumPeople = num
        case .selectSmall:
            switch currentState.isSmallSelected {
            case true:
                if let idx = currentState.clubInfo.petSizeType.firstIndex(of: .small) {
                    newState.clubInfo.petSizeType.remove(at: idx)
                }
            case false:
                newState.clubInfo.petSizeType.append(.small)
            }
            newState.isSmallSelected = !currentState.isSmallSelected
        case .selectMiddle:
            switch currentState.isMiddleSelected {
            case true:
                if let idx = currentState.clubInfo.petSizeType.firstIndex(of: .medium) {
                    newState.clubInfo.petSizeType.remove(at: idx)
                }
            case false:
                newState.clubInfo.petSizeType.append(.medium)
            }
            newState.isMiddleSelected = !currentState.isMiddleSelected
        case .selectLarge:
            switch currentState.isLargeSelected {
            case true:
                if let idx = currentState.clubInfo.petSizeType.firstIndex(of: .large) {
                    newState.clubInfo.petSizeType.remove(at: idx)
                }
            case false:
                newState.clubInfo.petSizeType.append(.large)
            }
            newState.isLargeSelected = !currentState.isLargeSelected
        case .selectMan:
            newState.clubInfo.eligibleSex = .man
            newState.isManSelected = true
            newState.isWomanSelected = false
            newState.isAllGenderSelected = false
        case .selectWoman:
            newState.clubInfo.eligibleSex = .woman
            newState.isManSelected = false
            newState.isWomanSelected = true
            newState.isAllGenderSelected = false
        case .selectAllGender:
            newState.clubInfo.eligibleSex = .all
            newState.isManSelected = false
            newState.isWomanSelected = false
            newState.isAllGenderSelected = true
        case .updateBreeds(let breeds):
            newState.clubInfo.eligibleBreed = breeds
        }
        newState.isCreateButtonEnabled = check()
        
        return newState
    }
    
    func categoryStateReset(_ state: State) -> State {
        var newState = state
        newState.isWalkButtonSelected = false
        newState.isPlaygroundButtonSelected = false
        newState.isDogCafeButtonSelected = false
        newState.isDogRestaurantButtonSelected = false
        newState.isFairButtonSelected = false
        newState.isEtcButtonSelected = false
        
        return newState
    }
    
    func check() -> Bool {
        return !currentState.clubInfo.meetingPlace.isEmpty &&
               currentState.clubInfo.category != nil &&
               !currentState.clubInfo.title.isEmpty
    }
    
    func createGather(_ gather: ClubInfo) {
        keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.createGatherRepository.createGather(accessToken: token, club: gather)
                    .subscribe(
                        onSuccess: {
                            this.readyToProceedMap.onNext(())
                            return
                        }, onFailure: { _ in
                            return
                        }
                    ).disposed(by: self.disposeBag)
               },
               onFailure: { _, _ in
            })
            .disposed(by: self.disposeBag)
    }
    
}
