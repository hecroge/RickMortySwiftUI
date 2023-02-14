//
//  CharactersEntityGateway.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Combine

enum CharactersEntityGatewayError: Error {
    case unaccessible
    case decodingError
}

protocol CharactersEntityGateway {
    func getCharacters(page: Int) -> AnyPublisher<CharactersResponse, CharactersEntityGatewayError>
}
