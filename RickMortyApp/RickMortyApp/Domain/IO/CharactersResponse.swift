//
//  CharactersResponse.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

struct CharactersResponse: Decodable {
    let info: CharactersInfo
    let results: [Character]
}

struct CharactersInfo: Decodable {
    let pages: Int
}
