//
//  AddPetReactor.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxSwift

final class AddPetReactor: Reactor {
    enum Action {
        case profileImageDidPick(Data?)
        case nameTextFieldDidEndEditing(String)
        case dateDidEndEditing(String)
        case smallPetButtonDidTap
        case middlePetButtonDidTap
        case largePetButtonDidTap
        case searchBarDidTap
        case selectedBreed(String)
        case manButtonDidTap
        case womanButtonDidTap
        case sexlessButtonDidTap
        case genderedButtonDidTap
        case activeButtonDidTap
        case docileButtonDidTap
        case sociableButtonDidTap
        case independentButtonDidTap
        case adaptableButtonDidTap
        case inadaptableButtonDidTap
        case addButtonDidTap
    }
    
    enum Mutation {
        case changeProfileImage(Data?)
        case updateNickname(String)
        case updateYearOfBirth(Int)
        case updateMonthOfBirth(Int)
        case selectSmall
        case selectMiddle
        case selectLarge
        case updateBreed(String)
        case selectMan
        case selectWoman
        case selectSexLess
        case selectGendered
        case selectActive
        case selectDocile
        case selectSociable
        case selectIndependent
        case selectAdaptable
        case selectInadaptable
    }
    
    struct State {
        var petInfo = PetRequestInfo()
        var isSmallSelected = false
        var isMiddleSelected = false
        var isLargeSelected = false
        var isManSelected = false
        var isWomanSelected = false
        var isSexlessSelected = false
        var isGenderedSelected = false
        var isActiveSelected = false
        var isDocileSelected = false
        var isSociableSelected = false
        var isIndependentSelected = false
        var isAdaptableSelected = false
        var isInadaptableSelected = false
        var isAddButtonEnabled = false
    }
    
    var initialState = State()
    private let addPetRepository: AddPetRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    
    internal var readyToProceedSearchBreed = PublishSubject<Void>()
    internal var readyToProceedProfile = PublishSubject<Void>()

    init(addPetRepository: AddPetRepositoryInterface, keychainUseCase: KeychainUseCaseInterface) {
        self.addPetRepository = addPetRepository
        self.keychainUseCase = keychainUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .profileImageDidPick(let data):
            return Observable.just(.changeProfileImage(data))
        case .nameTextFieldDidEndEditing(let name):
            return Observable.just(.updateNickname(name))
        case .dateDidEndEditing(let date):
            if date == "" { return Observable.empty() }
            let birth = date.components(separatedBy: "-").map{ Int($0)! }
            let year = birth.first!
            let month = birth.last!
            return Observable.concat([
                Observable.just(.updateYearOfBirth(year)),
                Observable.just(.updateMonthOfBirth(month))])
        case .smallPetButtonDidTap:
            return Observable.just(.selectSmall)
        case .middlePetButtonDidTap:
            return Observable.just(.selectMiddle)
        case .largePetButtonDidTap:
            return Observable.just(.selectLarge)
        case .searchBarDidTap:
            readyToProceedSearchBreed.onNext(())
            return Observable.empty()
        case .selectedBreed(let breed):
            return Observable.just(.updateBreed(breed))
        case .manButtonDidTap:
            return Observable.just(.selectMan)
        case .womanButtonDidTap:
            return Observable.just(.selectWoman)
        case .sexlessButtonDidTap:
            return Observable.just(.selectSexLess)
        case .genderedButtonDidTap:
            return Observable.just(.selectGendered)
        case .activeButtonDidTap:
            return Observable.just(.selectActive)
        case .docileButtonDidTap:
            return Observable.just(.selectDocile)
        case .sociableButtonDidTap:
            return Observable.just(.selectSociable)
        case .independentButtonDidTap:
            return Observable.just(.selectIndependent)
        case .adaptableButtonDidTap:
            return Observable.just(.selectAdaptable)
        case .inadaptableButtonDidTap:
            return Observable.just(.selectInadaptable)
        case .addButtonDidTap:
            addPet(currentState.petInfo)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .changeProfileImage(let data):
            newState.petInfo.imageFile = data
        case .updateNickname(let name):
            newState.petInfo.name = name
        case .updateYearOfBirth(let year):
            newState.petInfo.year = year
        case .updateMonthOfBirth(let month):
            newState.petInfo.month = month
        case .selectSmall:
            newState.petInfo.sizeType = "SMALL"
            newState.isSmallSelected = true
            newState.isMiddleSelected = false
            newState.isLargeSelected = false
        case .selectMiddle:
            newState.petInfo.sizeType = "MEDIUM"
            newState.isSmallSelected = false
            newState.isMiddleSelected = true
            newState.isLargeSelected = false
        case .selectLarge:
            newState.petInfo.sizeType = "LARGE"
            newState.isSmallSelected = false
            newState.isMiddleSelected = false
            newState.isLargeSelected = true
        case .updateBreed(let breed):
            newState.petInfo.breed = breed
        case .selectMan:
            newState.petInfo.sex = "MALE"
            newState.isManSelected = true
            newState.isWomanSelected = false
        case .selectWoman:
            newState.petInfo.sex = "FEMALE"
            newState.isManSelected = false
            newState.isWomanSelected = true
        case .selectSexLess:
            newState.petInfo.neutering = true
            newState.isSexlessSelected = true
            newState.isGenderedSelected = false
        case .selectGendered:
            newState.petInfo.neutering = false
            newState.isSexlessSelected = false
            newState.isGenderedSelected = true
        case .selectActive:
            newState.petInfo.tags?.append(PetTag.active.toString())
            newState.petInfo.neutering = false
            newState.isActiveSelected = true
            newState.isDocileSelected = false
        case .selectDocile:
            newState.petInfo.tags?.append(PetTag.docile.toString())
            newState.isActiveSelected = false
            newState.isDocileSelected = true
        case .selectSociable:
            newState.petInfo.tags?.append(PetTag.sociable.toString())
            newState.isSociableSelected = true
            newState.isIndependentSelected = false
        case .selectIndependent:
            newState.petInfo.tags?.append(PetTag.independent.toString())
            newState.isSociableSelected = false
            newState.isIndependentSelected = true
        case .selectAdaptable:
            newState.petInfo.tags?.append(PetTag.adaptable.toString())
            newState.isAdaptableSelected = true
            newState.isInadaptableSelected = false
        case .selectInadaptable:
            newState.petInfo.tags?.append(PetTag.inadaptable.toString())
            newState.isAdaptableSelected = false
            newState.isInadaptableSelected = true
        }
        newState.isAddButtonEnabled = check()
        
        return newState
    }
    
    func check() -> Bool {
        return currentState.petInfo.name != nil &&
        currentState.petInfo.year != nil &&
        currentState.petInfo.sizeType != nil &&
        currentState.petInfo.breed != nil &&
        currentState.petInfo.sex != nil &&
        currentState.petInfo.neutering != nil &&
        currentState.petInfo.tags != nil
    }
    
    func addPet(_ petInfo: PetRequestInfo) {
        keychainUseCase.getAccessToken()
            .subscribe(with: self,
               onSuccess: { this, token in
                this.addPetRepository.addPet(pet: petInfo, accessToken: token)
                    .subscribe(
                        onSuccess: {
                            this.readyToProceedProfile.onNext(())
                            return
                        }, onFailure: { _ in
                            return
                        }
                    ).disposed(by: self.disposeBag)
               },
               onFailure: { _, _ in
                }
            ).disposed(by: self.disposeBag)
        
    }
}
