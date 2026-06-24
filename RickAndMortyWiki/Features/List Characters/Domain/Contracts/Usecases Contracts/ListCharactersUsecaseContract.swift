//
//  ListCharactersUsecaseContract.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

protocol ListCharactersUsecaseContract {
    var isLoading: Bool { get }
    func loadNextPage() async -> Result<[RMCharacter], Error>
    func reset()
}
