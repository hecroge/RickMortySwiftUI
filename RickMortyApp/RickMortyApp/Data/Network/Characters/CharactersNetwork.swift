//
//  CharactersNetwork.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation
import Combine

class CharactersNetwork {
    func getCharacters(page: Int) -> AnyPublisher<Data, Error> {
        do {
            let url = try CharactersRouter.getCharacters(page: page).urlRequest(baseURL: Constants.baseURL)
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .mapError { (error: URLError) -> Error in
                    return error
                }
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Data, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
