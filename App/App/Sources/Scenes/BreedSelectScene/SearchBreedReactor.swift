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
        case breedDidTap(Int)
    }
    
    enum Mutation {
        case readyToSearch(String)
        case readyToSelectBreed(String)
    }
    
    struct State {
        var searchResult = [String]()
        var selectedBreeds = [String]()

    }
    
    let initialState = State()
    private var data = [String]()
    private let disposeBag = DisposeBag()
    
    init() {
        self.data = loadBreedFromCSV()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchBreedDidEndEditing(let text):
            return Observable.just(Mutation.readyToSearch(text))
        case .breedDidTap(let idx):
            return Observable.just(Mutation.readyToSelectBreed(currentState.searchResult[idx]))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .readyToSearch(let text):
            newState.searchResult = data.filter { $0.hasPrefix(text) }
        case .readyToSelectBreed(let breed):
            newState.selectedBreeds.append(breed)
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
