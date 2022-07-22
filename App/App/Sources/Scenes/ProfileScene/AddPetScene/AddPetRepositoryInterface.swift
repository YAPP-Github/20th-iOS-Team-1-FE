//
//  AddPetRepositoryInterface.swift
//  App
//
//  Created by 김나희 on 7/14/22.
//

import Foundation

import RxSwift

protocol AddPetRepositoryInterface {
    func addPet(pet: PetRequestInfo, accessToken: Data) -> Single<Void>
}
