//
//  SignUpAreaReactor.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import Foundation

import ReactorKit
import RxSwift

final class SignUpAreaReactor: Reactor {
    enum Action {
        case bigCityTextFieldDidTap
        case bigCityDidPick(Int)
        case smallCityTextFieldDidTap
        case smallCityDidPick(Int)
        case nextButtonDidTap
    }

    enum Mutation {
        case showBigCities([String])
        case updateBigCity(String?)
        case showSmallCities([String]?)
        case updateSmallCity(String?)
        case readyToStartTogaether
    }

    struct State {
        var user: UserAuthentification
        var selectedBigCity: String?
        var selectedSmallCity: String?
        var bigCityList = Area.allCases.map { $0.rawValue }
        var smallCityList: [String]?
        var isNextButtonEnabled = false
        var isReadyToStartTogaether = false
    }

    let initialState: State

    init(user: UserAuthentification) {
        initialState = State(user: user)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .bigCityTextFieldDidTap:
            return Observable.just(.showBigCities(currentState.bigCityList))
        case .bigCityDidPick(let city):
            return Observable.just(.updateBigCity(currentState.bigCityList[safe: city]))
        case .smallCityTextFieldDidTap:
            let smallCities = getSmallCities(bigCity: currentState.selectedBigCity)
            return Observable.just(.showSmallCities(smallCities))
        case .smallCityDidPick(let city):
            return Observable.just(.updateSmallCity(currentState.smallCityList?[safe: city]))
        case .nextButtonDidTap:
            return Observable.just(.readyToStartTogaether)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .showBigCities(let cities):
            newState.bigCityList = cities
        case .updateBigCity(let city):
            newState.selectedBigCity = city
            if newState.selectedBigCity != state.selectedBigCity {
                newState.selectedSmallCity = nil
                newState.isNextButtonEnabled = false
            }
        case .showSmallCities(let cities):
            newState.smallCityList = cities
        case .updateSmallCity(let city):
            newState.selectedSmallCity = city
            newState.isNextButtonEnabled = true
        case .readyToStartTogaether:
            newState.isReadyToStartTogaether = true
        }

        return newState
    }

    private func getSmallCities(bigCity: String?) -> [String]? {
        guard let bigCity = bigCity else {
            return nil
        }
        
        let smallCities = Area.getSmallCity(bigCity: bigCity)
    
        return smallCities
    }
}
