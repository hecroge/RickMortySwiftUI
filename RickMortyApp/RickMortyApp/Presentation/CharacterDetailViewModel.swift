//
//  CharacterDetailViewModel.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 13/2/23.
//

import Foundation
import Combine

enum CharacterDetailViewNavigationDestination: Equatable {}

protocol CharacterDetailViewModelOutput: ObservableObject {
    var character: CharacterListItemViewModel { get set }
}

protocol CharacterDetailViewModelInput: ObservableObject {}

protocol CharacterDetailViewModelProtocol: CharacterDetailViewModelOutput, CharacterDetailViewModelInput {}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    @Published var character: CharacterListItemViewModel

    // MARK: - Init
    init(character: CharacterListItemViewModel) {
        self.character = character
    }
}
