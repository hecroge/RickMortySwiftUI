//
//  CharactersUseCaseFactoryTest.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import XCTest
@testable import RickMortyApp

class CharactersUseCaseFactoryTest: XCTestCase {

    // MARK: - Test variables
    var sut: CharactersUseCaseFactory!
    var entityGateway: CharactersGatewayTestDummy!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        entityGateway = CharactersGatewayTestDummy()
        sut = CharactersUseCaseFactory(charactersGateway: entityGateway)
    }

    override func tearDownWithError() throws {
        sut = nil
        entityGateway = nil
    }

    // MARK: - Test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testFactoryGetCharactersUseCase() {
        let useCase = sut.getCharacters { _ in }
        XCTAssertNotNil(useCase as? GetCharacterUseCase)
    }
}
