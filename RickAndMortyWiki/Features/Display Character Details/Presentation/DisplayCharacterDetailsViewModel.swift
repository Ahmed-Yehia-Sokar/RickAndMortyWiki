//
//  DisplayCharacterDetailsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Admin on 24/06/2026.
//

import Foundation

struct DisplayCharacterDetailsViewModelProvider {
    static func provide(withCharacter character: RMCharacter) -> DisplayCharacterDetailsViewModel {
        DisplayCharacterDetailsViewModel(selectedCharacter: character)
    }
}

class DisplayCharacterDetailsViewModel {
    // MARK: - properties
    private let selectedCharacter: RMCharacter
    
    // MARK: - public methods
    init(selectedCharacter: RMCharacter) {
        self.selectedCharacter = selectedCharacter
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
}
