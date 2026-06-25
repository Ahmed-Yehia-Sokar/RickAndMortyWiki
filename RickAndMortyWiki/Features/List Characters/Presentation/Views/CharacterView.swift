//
//  CharacterView.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    let rmCharacter: RMCharacter
    
    var body: some View {
        HStack(spacing: 16.0) {
            characterImage
            characterDetails
            Spacer()
        }
    }
    
    private var characterImage: some View {
        KFImage(URL(string: rmCharacter.image))
            .placeholder {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
            .resizable()
            .scaledToFit()
            .frame(width: 90.0, height: 90.0)
            .clipShape(
                RoundedRectangle(cornerRadius: 12.0)
            )
    }
    
    private var characterDetails: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            characterNameText
            characterStatusText
            characterSpeciesText
        }
    }
    
    private var characterNameText: some View {
        Text(rmCharacter.name)
            .font(.headline)
    }

    private var characterStatusText: some View {
        Text(rmCharacter.status)
    }
    
    private var characterSpeciesText: some View {
        Text(rmCharacter.species)
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
    CharacterView(rmCharacter: character)
}
