//
//  CharacterDetailsApiRouter.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

import Foundation
import Alamofire

enum CharacterDetailsApiRouter: ApiRouterContract {
    case fetchEpisodes(episodeIDs: String)
    
    var method: String {
        switch self {
        case .fetchEpisodes:
            return HTTPMethod.get.rawValue
        }
    }
    var path: String {
        switch self {
        case .fetchEpisodes(let episodeIDs):
            return "\(ApiConstants.baseUrl)/episode/\(episodeIDs)"
        }
    }
}
