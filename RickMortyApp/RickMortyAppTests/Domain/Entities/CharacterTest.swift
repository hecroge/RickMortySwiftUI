//
//  CharacterTest.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import XCTest
@testable import RickMortyApp

class CharacterTest: XCTestCase {
    var sut: Character!

    override func setUpWithError() throws {
        sut = Character.main()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testMainParamsAreTheExpected() {
        XCTAssertEqual(CharacterTestData.mainId, sut.id)
        XCTAssertEqual(CharacterTestData.mainName, sut.name)
        XCTAssertEqual(CharacterTestData.mainStatus, sut.status)
        XCTAssertEqual(CharacterTestData.mainSpecies, sut.species)
        XCTAssertEqual(CharacterTestData.mainImage, sut.image)
        XCTAssertEqual(CharacterTestData.mainGender, sut.gender)
        XCTAssertEqual(CharacterOrigin(name: CharacterTestData.mainOrigin), sut.origin)
        XCTAssertEqual(CharacterLocation(name: CharacterTestData.mainLocation), sut.location)
    }
}
