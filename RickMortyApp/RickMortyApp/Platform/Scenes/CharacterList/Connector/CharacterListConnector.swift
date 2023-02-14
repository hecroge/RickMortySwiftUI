//
//  CharacterListConnector.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import SwiftUI

protocol CharacterListConnectorProtocol {
    func navigate(to destination: CharacterListViewNavigationDestination?) -> AnyView
}

extension CharacterListConnectorProtocol {
    func navigate(to destination: CharacterListViewNavigationDestination?) -> AnyView {
        AnyView(EmptyView())
    }
}

final class CharacterListConnector: CharacterListConnectorProtocol {

    // MARK: - Init
    init() {}
    
    // MARK: - Dependency injection
    func assembleModule() -> some View {
        let network = CharactersNetwork()
        let entityGateway = CharactersRepository(network: network)
        let useCaseFactory = CharactersUseCaseFactory(charactersGateway: entityGateway)
        let viewModel = CharacterListViewModel(useCaseFactory: useCaseFactory)
        return AnyView(CharacterListView(viewModel: viewModel, connector: self))
    }

    func navigate(to destination: CharacterListViewNavigationDestination?) -> AnyView {
        if let destination = destination {
            switch destination {
            case let .toDetail(character: character):
                 return AnyView(CharacterDetailConnector(character: character).assembleModule())
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}

