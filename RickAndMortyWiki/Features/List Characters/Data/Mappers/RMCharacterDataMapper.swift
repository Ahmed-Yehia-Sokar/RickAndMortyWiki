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
            let status = characterInfo.getString("status")
            let species = characterInfo.getString("species")
            
            let rmCharacter = RMCharacter(image: image,
                                          name: name,
                                          status: status,
                                          species: species)
            
            result.append(rmCharacter)
        }
        
        return result
    }
}
