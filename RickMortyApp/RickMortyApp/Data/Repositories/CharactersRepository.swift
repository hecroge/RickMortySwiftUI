//
//  CharactersRepository.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import Foundation
import Combine

final class CharactersRepository {
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    private var network: CharactersNetwork

    // MARK: - Init
    init(network: CharactersNetwork) {
        self.network = network
    }
}

extension CharactersRepository: CharactersEntityGateway {
    func getCharacters(page: Int) -> AnyPublisher<CharactersResponse, CharactersEntityGatewayError> {
        Future<CharactersResponse, CharactersEntityGatewayError> { [weak self] promise in
            self?.cancellable = self?.network.getCharacters(page: page).sink(receiveCompletion: { completion in
                if case .failure = completion {
                    return promise(.failure(.unaccessible))
                }
            }, receiveValue: { result in
                do {
                    let response: CharactersResponse = try JSONDecoder().decode(CharactersResponse.self, from: result)
                    return promise(.success(response))
                } catch {
                    print(error)
                    return promise(.failure(.decodingError))
                }
            })
        }.eraseToAnyPublisher()
    }
}
