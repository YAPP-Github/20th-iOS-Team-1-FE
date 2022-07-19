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
    }
    
    enum Mutation {
        case changeProfileImage(Data?)
        case updateNickname(String)
        case updateYearOfBirth(Int)
        case updateMonthOfBirth(Int)
        case selectSmall
        case selectMiddle
        case selectLarge
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
        case selectAddButton
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
        var isAddButtonSelected = false
    }
    
    let initialState = State()
    private let addPetRepository: AddPetRepositoryInterface
    private let disposeBag = DisposeBag()
    
    internal var readyToProceedSearchBreed = PublishSubject<Void>()

    
    init(addPetRepository: AddPetRepositoryInterface) {
        self.addPetRepository = addPetRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .profileImageDidPick(let data):
            return Observable.just(.changeProfileImage(data))
        case .nameTextFieldDidEndEditing(let name):
            return Observable.just(.updateNickname(name))
        case .dateDidEndEditing(let date):
            let birth = date.components(separatedBy: "/").map{ Int($0)! }
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .changeProfileImage(let data):
            newState.petInfo.imageFile = data
            break
        case .updateNickname(let name):
            newState.petInfo.name = name
            break
        case .updateYearOfBirth(let year):
            newState.petInfo.year = year
            break
        case .updateMonthOfBirth(let month):
            newState.petInfo.month = month
            break
        case .selectSmall:
            newState.petInfo.sizeType = .small
            newState.isSmallSelected = true
            newState.isMiddleSelected = false
            newState.isLargeSelected = false
        case .selectMiddle:
            newState.petInfo.sizeType = .medium
            newState.isSmallSelected = false
            newState.isMiddleSelected = true
            newState.isLargeSelected = false
        case .selectLarge:
            newState.petInfo.sizeType = .large
            newState.isSmallSelected = false
            newState.isMiddleSelected = false
            newState.isLargeSelected = true
        case .selectMan:
            newState.petInfo.sex = .man
            newState.isManSelected = true
            newState.isWomanSelected = false
        case .selectWoman:
            newState.petInfo.sex = .woman
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
        case .selectAddButton:
            break
        }
        
        return newState
    }
}
