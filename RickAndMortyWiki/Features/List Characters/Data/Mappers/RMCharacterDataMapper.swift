//
//  RMCharacterDataMapper.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation

struct RMCharacterDataMapper {
    static func map(fetchRMCharactersResponse response: Any) -> [RMCharacter] {
        var result = [RMCharacter]()
        guard let responseAsDic = response as? [String: Any],
              let resultsDic = responseAsDic["results"] as? [[String: Any]] else {
            return result
        }
        
        for characterInfo in resultsDic {
            let image = characterInfo.getString("image")
            let name = characterInfo.getString("name")
            let gender = characterInfo.getString("gender")
            let status = characterInfo.getString("status")
            let species = characterInfo.getString("species")
            let episodes = characterInfo.getArray("episodes") as [String]
            var origin = characterInfo.getString("origin")
            var location = ""
            
            if let locationDic = characterInfo["location"] as? [String: Any] {
                location = locationDic.getString("name")
            }
            if let originDic = characterInfo["origin"] as? [String: Any] {
                origin = originDic.getString("name")
            }
            
            let rmCharacter = RMCharacter(image: image,
                                          name: name,
                                          gender: gender,
                                          status: status,
                                          species: species,
                                          origin: origin,
                                          location: location,
                                          episodes: episodes)
            
            result.append(rmCharacter)
        }
        
        return result
    }
}
