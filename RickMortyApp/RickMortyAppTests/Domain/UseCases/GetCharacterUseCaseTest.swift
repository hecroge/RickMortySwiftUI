//
//  GetCharacterUseCaseTest.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import XCTest
import Combine
@testable import RickMortyApp

class GetCharacterUseCaseTest: XCTestCase {
    // MARK: - Test variables
    var sut: GetCharacterUseCase!
    var entityGateway: EntityGatewayMock!
    var isSuccess: Bool = false
    var error: DomainError?

    override func setUpWithError() throws {
        super.setUp()
        entityGateway = EntityGatewayMock()
        sut = GetCharacterUseCase(page: 1, entityGateway: entityGateway, handler: { [weak self] result in
            switch result {
            case .success:
                self?.isSuccess = true
            case let.failure(error):
                self?.error = error
            }
        })
    }

    override func tearDownWithError() throws {
        sut = nil
        entityGateway = nil
    }

    // MARK: - Test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testReportsSuccess() {
        entityGateway.error = nil
        sut.execute()

        XCTAssertTrue(isSuccess)
    }

    func testReportsNotSuccess() {
        entityGateway.error = .unaccessible
        sut.execute()

        XCTAssertFalse(isSuccess)
    }

    func testReportsUnaccessibleErrorFromEntityGateway() {
        entityGateway.error = .decodingError

        sut.execute()

        XCTAssertEqual(DomainError.persistence, error)
    }

    class EntityGatewayMock: CharactersGatewayTestDummy {
        var error: CharactersEntityGatewayError?
        var response = CharactersResponse.main()

        override func getCharacters(page: Int) -> AnyPublisher<CharactersResponse, CharactersEntityGatewayError> {
            if error != nil {
                return Fail(error: error ?? CharactersEntityGatewayError.unaccessible).eraseToAnyPublisher()
            } else {
                return Just(response).setFailureType(to: CharactersEntityGatewayError.self).eraseToAnyPublisher()
            }
        }
    }
}
