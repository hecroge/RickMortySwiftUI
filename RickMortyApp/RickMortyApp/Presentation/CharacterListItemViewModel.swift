//
//  CharacterListItemViewModel.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import Foundation

struct CharacterListItemViewModel: Equatable, Identifiable {
    var id: Int
    var name: String
    var image: String
    var status: String
    var species: String
    var gender: String
    var origin: String
    var location: String
}

extension CharacterListItemViewModel {
    init(character: Character) {
        id = character.id
        name = character.name
        status = character.status
        species = character.species
        gender = character.gender
        origin = character.origin.name
        location = character.location.name
        image = character.image
    }
}
