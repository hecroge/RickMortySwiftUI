//
//  CharacterDetailView.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import SwiftUI

struct CharacterDetailView<ViewModel>: View where ViewModel: CharacterDetailViewModelProtocol {
    // MARK: - Properties
    @ObservedObject private var viewModel: ViewModel
    private let connector: CharacterDetailConnectorProtocol

    private let imageWidthHeight: CGFloat = 120
    private let fontSize: CGFloat = 24
    private let smallPadding: CGFloat = 8
    private let generalPadding: CGFloat = 16
    private let statusText: String = "Characters_Detail_View_Status".localized()
    private let speciesText: String = "Characters_Detail_View_Species".localized()
    private let genderText: String = "Characters_Detail_View_Gender".localized()
    private let originText: String = "Characters_Detail_View_Origin".localized()
    private let locationText: String = "Characters_Detail_View_Location".localized()

    // MARK: - Init
    init(viewModel: ViewModel, connector: CharacterDetailConnectorProtocol) {
        self.viewModel = viewModel
        self.connector = connector
    }

    // MARK: - View
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.character.image)) { image in
                image
                    .resizable()

            } placeholder: {
                Color.gray
            }
            .scaledToFit()

            infoView(title: statusText, info: viewModel.character.status)
            infoView(title: speciesText, info: viewModel.character.species)
            infoView(title: genderText, info: viewModel.character.gender)
            infoView(title: originText, info: viewModel.character.origin)
            infoView(title: locationText, info: viewModel.character.location)

            Spacer()
        }
        .navigationTitle(viewModel.character.name)
    }

    // MARK: - Auxiliar views
    private func infoView(title: String, info: String) -> some View {
        VStack {
            Text(title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(info)
                .font(.system(size: fontSize))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, smallPadding)

            Divider()
        }
        .padding([.leading, .trailing], generalPadding)
    }
}
