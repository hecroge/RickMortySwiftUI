//
//  
//  CharacterListViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 14/2/23.
//
//

import XCTest
@testable import RickMortyApp

class CharacterListViewModelTest: XCTestCase {

    // MARK: - Test variables
    var sut: CharacterListViewModel!
    var useCaseFactory: UseCaseFactoryMock!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()
        useCaseFactory = UseCaseFactoryMock(charactersGateway: CharactersGatewayTestDummy())
        sut = CharacterListViewModel(useCaseFactory: useCaseFactory)
    }

    override func tearDownWithError() throws {
        sut = nil
        useCaseFactory = nil
        super.tearDown()
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    // MARK: - View model
    func testViewReadyInvokesGetCharactersUseCase() {
        sut.getCharacters()

        useCaseFactory.useCase.verifyExecuteInvoked()
    }

    func testGetCharactersReturnEmptyArray() {
        let expectedResponse: [CharacterListItemViewModel] = []
        useCaseFactory.response = CharactersResponse.alt()
        sut.getCharacters()

        XCTAssertEqual(expectedResponse, sut.characters)
    }

    func testGetCharactersReturnExpectedResponse() {
        let expectedResponse: [CharacterListItemViewModel] = [CharacterListItemViewModel.main()]
        useCaseFactory.response = CharactersResponse.main()
        sut.getCharacters()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            XCTAssertEqual(expectedResponse, self.sut.characters)
        })
    }

    // MARK: - Test doubles
    class UseCaseFactoryMock: CharactersUseCaseFactory {
        var errorType: DomainError = .persistence
        var useCase: GetCharactersUseCaseMock!
        var handlerIsSuccess: Bool = true
        var response: CharactersResponse = CharactersResponse.main()

        override func getCharacters(page: Int = 1, handler: @escaping Handler<CharactersResponse>) -> UseCase {
            useCase = GetCharactersUseCaseMock(response: response,
                                               handlerIsSuccess: handlerIsSuccess,
                                               errorType: errorType,
                                               handler: handler)
            return useCase
        }
    }

    class GetCharactersUseCaseMock: UseCase {
        private var executeWasInvoked = 0
        private var handler: Handler<CharactersResponse>
        private var errorType: DomainError
        private var handlerIsSuccess: Bool
        private var response: CharactersResponse

        init(response: CharactersResponse, handlerIsSuccess: Bool,
             errorType: DomainError, handler: @escaping Handler<CharactersResponse>) {
            self.response = response
            self.handlerIsSuccess = handlerIsSuccess
            self.errorType = errorType
            self.handler = handler
        }

        func execute() {
            executeWasInvoked += 1
            if handlerIsSuccess {
                handler(.success(response))
            } else {
                handler(.failure(errorType))
            }
        }

        func verifyExecuteInvoked(file: StaticString = #filePath, line: UInt = #line) {
            XCTAssertEqual(1, executeWasInvoked, "execute() invoked", file: file, line: line)
        }
    }
}
