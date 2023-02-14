//
//  JsonHelper.swift
//  RickMortyAppTests
//
//  Created by Héctor Rogel on 11/2/23.
//

import Foundation
import XCTest
import Combine
@testable import RickMortyApp

class JsonHelper {
    static func getData(fromJSON fileName: String) throws -> Data {
        guard let url = Bundle.main.path(forResource: fileName, ofType: "json") else {
            XCTFail("Missing File: \(fileName).json")
            throw CharactersEntityGatewayError.unaccessible
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url))
            return data
        } catch {
            throw error
        }
    }
}
