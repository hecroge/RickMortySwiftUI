//
//  CharacterListViewModel+Test.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation
@testable import RickMortyApp

extension CharacterListItemViewModel {
    static func main() -> CharacterListItemViewModel {
        CharacterListItemViewModel(id: CharacterTestData.mainId,
                                   name: CharacterTestData.mainName,
                                   image: CharacterTestData.mainImage,
                                   status: CharacterTestData.mainStatus,
                                   species: CharacterTestData.mainSpecies,
                                   gender: CharacterTestData.mainGender,
                                   origin: CharacterTestData.mainOrigin,
                                   location: CharacterTestData.mainLocation)
    }
}
