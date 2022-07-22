//
//  SearchBreedReactor.swift
//  App
//
//  Created by 김나희 on 7/19/22.
//

import UIKit

import ReactorKit
import RxSwift

final class SearchBreedReactor: Reactor {
    enum Action {
        case searchBreedDidEndEditing(String)
        case breedSelected(Int)
        case breedDeselected(Int)
        case registerButtonDidTap
    }
    
    enum Mutation {
        case readyToSearch(String)
        case readyToSelectBreed(String)
        case readyToDeselectBreed(String)
    }
    
    struct State {
        var isEnabledRegister = false
        var searchResult = [String]()
        var selectedBreeds = [String]()
    }
    
    let initialState = State()
    private var data = [String]()
    private let disposeBag = DisposeBag()
    internal var readyToRegisterBreed = PublishSubject<[String]>()
    
    init() {
        self.data = loadBreedFromCSV()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchBreedDidEndEditing(let text):
            return Observable.just(Mutation.readyToSearch(text))
        case .breedSelected(let idx):
            return Observable.just(Mutation.readyToSelectBreed(currentState.searchResult[idx]))
        case .breedDeselected(let idx):
            return Observable.just(Mutation.readyToDeselectBreed(currentState.searchResult[idx]))
        case .registerButtonDidTap:
            readyToRegisterBreed.onNext(currentState.selectedBreeds)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .readyToSearch(let text):
            newState.searchResult = data.filter { $0.hasPrefix(text) }
        case .readyToSelectBreed(let breed):
            if !currentState.selectedBreeds.contains(breed) {
                newState.selectedBreeds.append(breed)
            }
            newState.isEnabledRegister = true
        case .readyToDeselectBreed(let breed):
            newState.selectedBreeds = currentState.selectedBreeds.filter { $0 != breed }
            if newState.selectedBreeds.count < 1 {
                newState.isEnabledRegister = false
            }
        }
        
        return newState
    }
    
    private func loadBreedFromCSV() -> [String] {
        let path = Bundle.main.path(forResource: "견종목록", ofType: "csv")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let dataEncoded = String(data: data, encoding: .utf8)
            guard let elements = dataEncoded?.components(separatedBy: "\n").map({ $0.components(separatedBy: ",").first! }) else {
                return []
            }
            return elements
        } catch  {
            print("Error reading CSV file")
            return []
        }
   }
}
