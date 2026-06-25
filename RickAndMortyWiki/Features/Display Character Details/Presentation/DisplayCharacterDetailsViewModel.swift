//
//  DisplayCharacterDetailsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Admin on 24/06/2026.
//

import Foundation

struct DisplayCharacterDetailsViewModelProvider {
    static func provide(withCharacter character: RMCharacter) -> DisplayCharacterDetailsViewModel {
        let usecase = CharacterDetailsUsecaseProvider.provide()
        return DisplayCharacterDetailsViewModel(selectedCharacter: character,
                                                usecase: usecase)
    }
}

@Observable
class DisplayCharacterDetailsViewModel {
    enum EpisodesState {
        case loading
        case loaded([Episode])
        case empty
        case error(String)
    }

    // MARK: - properties
    private let selectedCharacter: RMCharacter
    private let usecase: CharacterDetailsUsecaseContract
    private(set) var episodesState = EpisodesState.loading

    // MARK: - public methods
    init(selectedCharacter: RMCharacter,
         usecase: CharacterDetailsUsecaseContract) {
        self.selectedCharacter = selectedCharacter
        self.usecase = usecase
    }
    
    func getImagePath() -> URL? {
        return URL(string: selectedCharacter.image)
    }
    
    func getCharacterName() -> String {
        selectedCharacter.name
    }
    
    func getCharacterGender() -> String {
        selectedCharacter.gender
    }
    
    func getCharacterStatus() -> String {
        selectedCharacter.status
    }
    
    func getCharacterSpecies() -> String {
        selectedCharacter.species
    }
    
    func getCharacterOrigin() -> String {
        selectedCharacter.origin
    }
    
    func getCharacterLocation() -> String {
        selectedCharacter.location
    }
    
    func fetchEpisodes() async {
        episodesState = .loading

        guard !selectedCharacter.episodes.isEmpty else {
            episodesState = .empty
            return
        }

        let result = await usecase.fetchEpisodes(from: selectedCharacter.episodes)
        switch result {
        case .failure(let error):
            episodesState = .error(error.localizedDescription)
        case .success(let episodes):
            episodesState = episodes.isEmpty ? .empty : .loaded(episodes)
        }
    }
}
