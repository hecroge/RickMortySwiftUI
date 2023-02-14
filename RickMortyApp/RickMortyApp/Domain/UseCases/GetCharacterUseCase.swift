//
//  GetCharacterUseCase.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Combine

final class GetCharacterUseCase {
    // MARK: - Properties
    private let entityGateway: CharactersEntityGateway
    private let handler: Handler<CharactersResponse>
    private var cancellable: AnyCancellable?
    private let page: Int

    // MARK: - Init
    init(page: Int, entityGateway: CharactersEntityGateway, handler: @escaping Handler<CharactersResponse>) {
        self.page = page
        self.entityGateway = entityGateway
        self.handler = handler
    }
}

extension GetCharacterUseCase: UseCase {
    func execute() {
        cancellable = entityGateway.getCharacters(page: page)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    self.handler(.failure(.persistence))
                }
            }, receiveValue: { value in
                self.handler(.success(value))
            })
    }
}
