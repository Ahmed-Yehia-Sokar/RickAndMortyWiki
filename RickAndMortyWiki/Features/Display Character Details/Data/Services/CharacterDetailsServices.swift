//
//  CharacterDetailsServices.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

import Foundation

struct CharacterDetailsServicesProvider {
    static func provide() -> CharacterDetailsServices {
        let apiClient = ApiClient()
        return CharacterDetailsServices(apiClient: apiClient)
    }
}

struct CharacterDetailsServices: CharacterDetailsServicesContract {
    // MARK: - properties
    private let apiClient: ApiClientContract
    
    // MARK: - public methods
    init(apiClient: ApiClientContract) {
        self.apiClient = apiClient
    }
    
    func fetchEpisodes(from urls: [String]) async -> Result<[Episode], any Error> {
        do {
            let episodeIDs = episodeIDs(from: urls)
            let endpoint = CharacterDetailsApiRouter.fetchEpisodes(episodeIDs: episodeIDs)
            let data = try await apiClient.performRequest(endpoint: endpoint)
            let json = try JSONSerialization.jsonObject(with: data)
            let episodes = EpisodeDataMapper.map(fetchEpisodesResponse: json)
            return .success(episodes)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - private methods
    private func episodeIDs(from urls: [String]) -> String {
        urls
            .compactMap { $0.split(separator: "/").last }
            .joined(separator: ",")
    }
}
