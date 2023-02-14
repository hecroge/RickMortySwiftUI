//
//  CharacterRepositoryTests.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import XCTest
import Combine
@testable import RickMortyApp

class CharacterRepositoryTests: XCTestCase {
    // MARK: - Test variables
    private let url = "url"
    private var sut: CharactersRepository!
    private var network: CharactersNetworkMock!
    private var responseData: Data!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()
        network = CharactersNetworkMock()
        sut = CharactersRepository(network: network)
        responseData = try JsonHelper.getData(fromJSON: "Characters")
    }

    override func tearDownWithError() throws {
        sut = nil
        network = nil
        super.tearDown()
    }

    // MARK: - Tests
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testCreateInvokesCompletionHandler() {
        var handlerInvoked = 0
        let page = 1
        let cancellable = sut.getCharacters(page: page).sink { completion in
            if case .failure = completion {
                handlerInvoked += 1
            }
        } receiveValue: { _ in }
        XCTAssertEqual(1, handlerInvoked)
        cancellable.cancel()
    }

    func testCharactersIsSuccess() {
        let page = 1
        network.isSuccess = true
        network.responseData = responseData
        let expectedResponse: Bool = true
        var response: Bool?

        let cancellable = sut.getCharacters(page: page).sink { completion in
            if case .failure = completion {
                response = false
            }
        } receiveValue: { _ in
            response = true
        }

        XCTAssertEqual(expectedResponse, response)
        cancellable.cancel()
    }

    func testGetCharactersReturnsError() {
        let page = 1
        network.error = .unaccessible
        var returnedError: CharactersEntityGatewayError!
        let expectedError: CharactersEntityGatewayError = .unaccessible

        let cancellable = sut.getCharacters(page: page).sink { completion in
            if case .failure(let error) = completion {
                returnedError = error
            }
        } receiveValue: { _ in }

        XCTAssertEqual(expectedError, returnedError)
        cancellable.cancel()
    }

    // MARK: Test doubles
    class CharactersNetworkMock: CharactersNetwork {
        var error: CharactersEntityGatewayError = .decodingError
        var isSuccess: Bool = false
        var responseData: Data = Data()

        override func getCharacters(page: Int) -> AnyPublisher<Data, Error> {
            Future<Data, Error> { promise in
                if self.isSuccess {
                    promise(.success(self.responseData))
                } else {
                    promise(.failure(self.error))
                }
            }.eraseToAnyPublisher()
        }
    }
}
