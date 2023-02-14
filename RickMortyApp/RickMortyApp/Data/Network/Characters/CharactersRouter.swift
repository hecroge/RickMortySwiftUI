//
//  CharactersRouter.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

public enum CharactersRouter: NetworkCall {

case getCharacters(page: Int)

    var path: String {
        switch self {
        case .getCharacters(let page):
            return Endpoints.getCharacters + String(page)
        }
    }

    var method: String {
        switch self {
        case .getCharacters:
            return "GET"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getCharacters:
            return ["Accept": "application/json", "Content-Type": "application/json"]
        }
    }

    func body() throws -> Data? {
        return nil
    }
}
