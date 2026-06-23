//
//  RMCharactersServices.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation

struct RMCharactersServicesProvider {
    static func provide() -> RMCharactersServices {
        RMCharactersServices()
    }
}

struct RMCharactersServices: RMCharactersServicesContract {
    // MARK: - properties
    private let apiClient: ApiClientContract

    // MARK: - public methods
    init(apiClient: ApiClientContract = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchRMCharacters(pageNumber: Int) async -> Result<[RMCharacter], Error> {
        do {
            let endpoint = RMCharactersApiRouter.fetchRMCharacters(pageNumber: pageNumber)
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let json = try JSONSerialization.jsonObject(with: data)
            let characters = RMCharacterDataMapper.map(fetchRMCharactersResponse: json)
            return .success(characters)
        } catch {
            return .failure(error)
        }
    }
}
