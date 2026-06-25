//
//  CharacterDetailsServicesContract.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

protocol CharacterDetailsServicesContract {
    func fetchEpisodes(from urls: [String]) async -> Result<[Episode], Error>
}
