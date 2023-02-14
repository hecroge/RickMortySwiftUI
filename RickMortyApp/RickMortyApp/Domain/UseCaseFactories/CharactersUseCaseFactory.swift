//
//  CharactersUseCaseFactory.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

class CharactersUseCaseFactory {
    // MARK: - Properties
    let charactersGateway: CharactersEntityGateway

    // MARK: - Init
    init(charactersGateway: CharactersEntityGateway) {
        self.charactersGateway = charactersGateway
    }

    // MARK: - Factory methods
    func getCharacters(page: Int = 1, handler: @escaping Handler<CharactersResponse>) -> UseCase {
        GetCharacterUseCase(page: page, entityGateway: charactersGateway, handler: handler)
    }
}
