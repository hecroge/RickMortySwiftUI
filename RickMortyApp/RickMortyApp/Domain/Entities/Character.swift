//
//  Character.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
}

struct CharacterOrigin: Codable, Equatable {
    let name: String
}

struct CharacterLocation: Codable, Equatable {
    let name: String
}
