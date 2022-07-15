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
        case gallaryImageDidPick(Data?)
        case smallPetButtonDidTap
        case middlePetButtonDidTap
        case largePetButtonDidTap
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
    
    init(addPetRepository: AddPetRepositoryInterface) {
        self.addPetRepository = addPetRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .gallaryImageDidPick(let data):
            return Observable.just(.changeProfileImage(data))
        case .smallPetButtonDidTap:
            return Observable.just(.selectSmall)
        case .middlePetButtonDidTap:
            return Observable.just(.selectMiddle)
        case .largePetButtonDidTap:
            return Observable.just(.selectLarge)
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
            break
        case .updateNickname(let name):
            break
        case .updateYearOfBirth(let year):
            break
        case .updateMonthOfBirth(let month):
            break
        case .selectSmall:
            newState.isSmallSelected = true
            newState.isMiddleSelected = false
            newState.isLargeSelected = false
        case .selectMiddle:
            newState.isSmallSelected = false
            newState.isMiddleSelected = true
            newState.isLargeSelected = false
        case .selectLarge:
            newState.isSmallSelected = false
            newState.isMiddleSelected = false
            newState.isLargeSelected = true
        case .selectMan:
            newState.isManSelected = true
            newState.isWomanSelected = false
        case .selectWoman:
            newState.isManSelected = false
            newState.isWomanSelected = true
        case .selectSexLess:
            newState.isSexlessSelected = true
            newState.isGenderedSelected = false
        case .selectGendered:
            newState.isSexlessSelected = false
            newState.isGenderedSelected = true
        case .selectActive:
            newState.isActiveSelected = true
            newState.isDocileSelected = false
        case .selectDocile:
            newState.isActiveSelected = false
            newState.isDocileSelected = true
        case .selectSociable:
            newState.isSociableSelected = true
            newState.isIndependentSelected = false
        case .selectIndependent:
            newState.isSociableSelected = false
            newState.isIndependentSelected = true
        case .selectAdaptable:
            newState.isAdaptableSelected = true
            newState.isInadaptableSelected = false
        case .selectInadaptable:
            newState.isAdaptableSelected = false
            newState.isInadaptableSelected = true
        case .selectAddButton:
            break
        }
        
        return newState
    }
}
