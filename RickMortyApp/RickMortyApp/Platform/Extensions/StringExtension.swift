//
//  StringExtension.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
