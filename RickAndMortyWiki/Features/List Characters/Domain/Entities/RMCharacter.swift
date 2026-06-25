//
//  RMCharacter.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation

struct RMCharacter: Equatable {
    // MARK: - properties
    let image: String,
        name: String,
        gender: String,
        status: String,
        species: String,
        origin: String,
        location: String,
        episodes: [String]
}
