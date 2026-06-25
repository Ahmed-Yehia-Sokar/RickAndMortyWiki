//
//  EpisodeDataMapper.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

struct EpisodeDataMapper {
    static func map(fetchEpisodesResponse response: Any) -> [Episode] {
        var result = [Episode]()
        guard let responseAsDic = response as? [[String: Any]] else {
            return result
        }
        
        for episodeInfo in responseAsDic {
            let name = episodeInfo.getString("name")
            let airDate = episodeInfo.getString("air_date")
            let code = episodeInfo.getString("episode")
            let episode = Episode(name: name,
                                  airDate: airDate,
                                  code: code)
            result.append(episode)
        }
        
        return result
    }
}
