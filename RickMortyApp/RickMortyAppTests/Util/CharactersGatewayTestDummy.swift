//
//  CharactersGatewayTestDummy.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 10/2/23.
//

import Combine
@testable import RickMortyApp

class CharactersGatewayTestDummy: CharactersEntityGateway {
    func getCharacters(page: Int) -> AnyPublisher<CharactersResponse, CharactersEntityGatewayError> {
        Empty().setFailureType(to: CharactersEntityGatewayError.self).eraseToAnyPublisher()
    }
}
