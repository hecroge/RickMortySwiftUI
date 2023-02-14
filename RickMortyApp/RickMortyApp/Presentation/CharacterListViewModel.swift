//
//  CharacterListViewModel.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import Foundation
import Combine

enum CharacterListViewNavigationDestination: Equatable {
    case toDetail(character: CharacterListItemViewModel)
}

protocol CharacterListViewModelOutput: ObservableObject {
    var navigationDestination: CharacterListViewNavigationDestination? { get set }
    var navigate: Bool { get set }
    var characters: [CharacterListItemViewModel] { get set }
    var isLoading: Bool { get set }
    func getCharacters()
}

protocol CharacterListViewModelInput: ObservableObject {
    func characterSelected(character: CharacterListItemViewModel)
}

protocol CharacterListViewModelProtocol: CharacterListViewModelOutput,
                                     CharacterListViewModelInput {}

class CharacterListViewModel: CharacterListViewModelProtocol {
    @Published var navigationDestination: CharacterListViewNavigationDestination?
    @Published var navigate: Bool = false
    @Published var characters: [CharacterListItemViewModel] = []
    @Published var isLoading: Bool = true
    private let useCaseFactory: CharactersUseCaseFactory
    private var useCase: UseCase?
    private var totalPages: Int = 0
    private var nextPage: Int = 1

    // MARK: - Init
    init(useCaseFactory: CharactersUseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }

    // MARK: - Input functions
    func getCharacters() {
        executeGetCharactersUseCase()
    }

    func characterSelected(character: CharacterListItemViewModel) {
        self.navigationDestination = .toDetail(character: character)
        self.navigate = true
    }

    // MARK: - UseCases
    private func executeGetCharactersUseCase() {
        useCase = useCaseFactory.getCharacters(page: self.nextPage, handler: { result in
            if case .success(let response) = result {
                self.totalPages = response.info.pages
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: response.results.map { CharacterListItemViewModel(character: $0) })
                }
                if self.nextPage + 1 < self.totalPages {
                    self.nextPage += 1
                }
                self.useCase = nil
            }
        })
        useCase?.execute()
    }
}
