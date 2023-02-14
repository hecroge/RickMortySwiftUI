//
//  CharacterListView.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelProtocol {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    @State var searchText: String = ""
    private let connector: CharacterListConnectorProtocol
    private let imageWidthHeight: CGFloat = 60
    private let navTitle: String = "Characters_View_Title".localized()

    var searchResults: [CharacterListItemViewModel] {
        if searchText.isEmpty {
            return viewModel.characters
        } else {
            return viewModel.characters.filter { $0.name.contains(searchText) }
        }
    }

    // MARK: - Init
    init(viewModel: ViewModel, connector: CharacterListConnectorProtocol) {
        self.viewModel = viewModel
        self.connector = connector
    }

    // MARK: - View
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: connector.navigate(to: viewModel.navigationDestination),
                               isActive: $viewModel.navigate) {
                    EmptyView()
                }

                List {
                    ForEach(searchResults) { character in
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()

                                } placeholder: {
                                    Color.gray
                                }
                                .scaledToFit()
                                .frame(width: imageWidthHeight, height: imageWidthHeight)
                                Text(character.name)
                            }
                            .onAppear {
                                if character == viewModel.characters.last {
                                    viewModel.getCharacters()
                                }
                            }
                            
                            Divider()
                        }
                        .background(Color.white.opacity(0.001))
                        .onTapGesture {
                            viewModel.characterSelected(character: character)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .searchable(text: $searchText)
                .listStyle(.plain)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(navTitle)
            .onAppear {
                viewModel.getCharacters()
            }
        }
    }
}
