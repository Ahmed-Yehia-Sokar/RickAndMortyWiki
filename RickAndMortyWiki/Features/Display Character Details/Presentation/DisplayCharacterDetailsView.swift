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
                episodesSection
            }
            .padding()
        }
        .task {
            await viewModel.fetchEpisodes()
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

    private var episodesSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text("Episodes")
                .font(.headline)
            
            switch viewModel.episodesState {
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .empty:
                Text("No episodes.")
            case .loaded(let episodes):
                VStack(spacing: 8.0) {
                    ForEach(episodes, id: \.code) { episode in
                        episodeRow(episode)
                    }
                }
            case .error(let message):
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(message)
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchEpisodes()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func episodeRow(_ episode: Episode) -> some View {
        HStack {
            Text(episode.code)
                .bold()
            Text(episode.name)
            Spacer()
            Text(episode.airDate)
                .foregroundColor(.secondary)
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
