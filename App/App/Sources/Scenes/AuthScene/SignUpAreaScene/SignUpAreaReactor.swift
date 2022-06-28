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
        case updateBigCity(String)
        case showSmallCities([String])
        case updateSmallCity(String)
        case readyToStartTogaether
    }

    struct State {
        var user: UserAccount
        var selectedBigCity: String?
        var selectedSmallCity: String?
        var bigCityList = Area.allCases.map { $0.rawValue }
        var smallCityList = [String]()
        var isNextButtonEnabled = false
        var isReadyToStartTogaether = false
    }

    let initialState: State
    
    private let signUpRepository: SignUpRepositoryInterface
    private let keychainUseCase: KeychainUseCaseInterface
    private let disposeBag = DisposeBag()
    
    init(user: UserAccount, keychainUseCase: KeychainUseCaseInterface, signUpRepository: SignUpRepositoryInterface) {
        initialState = State(user: user)
        self.signUpRepository = signUpRepository
        self.keychainUseCase = keychainUseCase
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .bigCityTextFieldDidTap:
            return Observable.just(.showBigCities(currentState.bigCityList))
        case .bigCityDidPick(let city):
            if let bigCity = currentState.bigCityList[safe: city] {
                return Observable.just(.updateBigCity(bigCity))
            } else {
                return Observable.empty()
            }
        case .smallCityTextFieldDidTap:
            if let smallCities = getSmallCities(bigCity: currentState.selectedBigCity) {
                return Observable.just(.showSmallCities(smallCities))
            } else {
                return Observable.empty()
            }
        case .smallCityDidPick(let city):
            if let smallCity = currentState.smallCityList[safe: city] {
                return Observable.just(.updateSmallCity(smallCity))
            } else {
                return Observable.empty()
            }
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
            newState.user.bigCity = city
            newState.selectedBigCity = city
            if newState.selectedBigCity != state.selectedBigCity {
                newState.user.smallCity = nil
                newState.selectedSmallCity = nil
                newState.smallCityList = []
                newState.isNextButtonEnabled = false
            }
        case .showSmallCities(let cities):
            newState.smallCityList = cities
        case .updateSmallCity(let city):
            newState.user.smallCity = city
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
    
    private func signUp(user: UserAccount) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.keychainUseCase.getAccessToken()
                .subscribe(with: self,
                   onSuccess: { this, token in
                    this.signUpRepository.signUp(user: user, accessToken: token)
                        .subscribe(
                            onSuccess: {
                                observer.onNext(Mutation.readyToStartTogaether)
                                return
                            
                            }, onFailure: { _ in
                                #warning("회원가입 실패할 경우 버튼을 눌러도 반응이 없음")
                                return
                            }
                        ).disposed(by: self.disposeBag)
                   },
                   onFailure: { _,_ in
                        #warning("회원가입 실패할 경우 버튼을 눌러도 반응이 없음")
                        return
                   }
                ).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
