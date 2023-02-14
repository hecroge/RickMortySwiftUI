//
//  CharacterResponse+Test.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

@testable import RickMortyApp

extension CharactersResponse {
    static func main() -> CharactersResponse {
        CharactersResponse(info: CharactersInfo(pages: 1),
                           results: [Character.main()])
    }

    static func alt() -> CharactersResponse {
        CharactersResponse(info: CharactersInfo(pages: 1),
                           results: [])
    }
}
