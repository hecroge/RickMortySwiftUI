//
//  CharactersResponseTest.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import XCTest
@testable import RickMortyApp

class CharactersResponseTest: XCTestCase {

    // MARK: - Test variables
    var sut: CharactersResponse!

    override func setUpWithError() throws {
        super.setUp()
        sut = CharactersResponse.main()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    // MARK: - Basic test.
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testCharactersResponseExtractsPropertiesFromMainResponse() {
        XCTAssertEqual(CharactersResponse.main().info.pages, CharacterTestData.mainPages)
        XCTAssertEqual(CharactersResponse.main().results.first?.id, CharacterTestData.mainId)
        XCTAssertEqual(CharactersResponse.main().results.first?.name, CharacterTestData.mainName)
        XCTAssertEqual(CharactersResponse.main().results.first?.status, CharacterTestData.mainStatus)
        XCTAssertEqual(CharactersResponse.main().results.first?.species, CharacterTestData.mainSpecies)
        XCTAssertEqual(CharactersResponse.main().results.first?.image, CharacterTestData.mainImage)
        XCTAssertEqual(CharactersResponse.main().results.first?.gender, CharacterTestData.mainGender)
        XCTAssertEqual(CharactersResponse.main().results.first?.origin.name, CharacterTestData.mainOrigin)
        XCTAssertEqual(CharactersResponse.main().results.first?.location.name, CharacterTestData.mainLocation)
    }
}
