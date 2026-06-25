//
//  CharacterDetailsUsecaseContract.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

protocol CharacterDetailsUsecaseContract {
    func fetchEpisodes(from urls: [String]) async -> Result<[Episode], Error>
}
