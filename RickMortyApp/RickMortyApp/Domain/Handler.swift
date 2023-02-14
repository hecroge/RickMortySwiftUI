//
//  Handler.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 10/2/23.
//

import Foundation

enum DomainError: Error {
    case persistence
    case locationNotAllowed
}

typealias Handler<T> = (Result<T, DomainError>) -> Void
