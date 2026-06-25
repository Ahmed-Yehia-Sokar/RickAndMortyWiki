//
//  CharacterDetailsUsecase.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

struct CharacterDetailsUsecaseProvider {
    static func provide() -> CharacterDetailsUsecase {
        let services = CharacterDetailsServicesProvider.provide()
        return CharacterDetailsUsecase(services: services)
    }
}

class CharacterDetailsUsecase: CharacterDetailsUsecaseContract {
    // MARK: - properties
    private let services: CharacterDetailsServicesContract

    // MARK: - public methods
    init(services: CharacterDetailsServicesContract) {
        self.services = services
    }

    func fetchEpisodes(from urls: [String]) async -> Result<[Episode], Error> {
        await services.fetchEpisodes(from: urls)
    }
}
