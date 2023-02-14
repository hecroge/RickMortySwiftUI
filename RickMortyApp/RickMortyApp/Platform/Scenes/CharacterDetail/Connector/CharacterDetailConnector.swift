//
//  CharacterDetailConnector.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import SwiftUI

protocol CharacterDetailConnectorProtocol {
    func navigate(to destination: CharacterDetailViewNavigationDestination?) -> AnyView
}

extension CharacterDetailConnectorProtocol {
    func navigate(to destination: CharacterDetailViewNavigationDestination?) -> AnyView {
        AnyView(EmptyView())
    }
}

final class CharacterDetailConnector: CharacterDetailConnectorProtocol {
    private var character: CharacterListItemViewModel

    // MARK: - Init
    init(character: CharacterListItemViewModel) {
        self.character = character
    }

    // MARK: - Dependency injection
    func assembleModule() -> some View {
        let viewModel = CharacterDetailViewModel(character: character)
        return AnyView(CharacterDetailView(viewModel: viewModel, connector: self))
    }
}
