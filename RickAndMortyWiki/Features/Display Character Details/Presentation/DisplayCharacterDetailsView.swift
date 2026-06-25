//
//  DisplayCharacterDetailsView.swift
//  RickAndMortyWiki
//
//  Created by Admin on 24/06/2026.
//

import SwiftUI
import Kingfisher

struct DisplayCharacterDetailsView: View {
    let viewModel: DisplayCharacterDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                characterImage
                characterNameText
                detailsList
            }
            .padding()
        }
    }

    private var characterImage: some View {
        KFImage(viewModel.getImagePath())
            .placeholder {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .resizable()
            .scaledToFit()
            .frame(width: 200.0,
                   height: 200.0)
            .clipShape(
                RoundedRectangle(cornerRadius: 12.0)
            )
    }

    private var characterNameText: some View {
        Text(viewModel.getCharacterName())
            .font(.title)
            .bold()
    }

    private var detailsList: some View {
        VStack(spacing: 12.0) {
            detailRow(label: "Status",
                      value: viewModel.getCharacterStatus())
            detailRow(label: "Species",
                      value: viewModel.getCharacterSpecies())
            detailRow(label: "Gender",
                      value: viewModel.getCharacterGender())
            detailRow(label: "Origin",
                      value: viewModel.getCharacterOrigin())
            detailRow(label: "Location",
                      value: viewModel.getCharacterLocation())
        }
    }

    private func detailRow(label: String,
                           value: String) -> some View {
        HStack {
            Text(label)
                .bold()
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    let character = RMCharacter(image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                name: "Rick",
                                gender: "Male",
                                status: "Alive",
                                species: "Human",
                                origin: "USA",
                                location: "USA",
                                episodes: ["https://rickandmortyapi.com/api/episode/1"])
    let viewModel = DisplayCharacterDetailsViewModelProvider.provide(withCharacter: character)
    DisplayCharacterDetailsView(viewModel: viewModel)
}
