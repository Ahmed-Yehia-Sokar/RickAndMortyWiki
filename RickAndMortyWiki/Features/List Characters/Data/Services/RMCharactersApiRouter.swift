//
//  RMCharactersApiRouter.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation
import Alamofire

enum RMCharactersApiRouter: ApiRouterContract {
    case fetchRMCharacters(pageNumber: Int)
    
    var method: HTTPMethod {
        switch self {
        case .fetchRMCharacters:
            return .get
        }
    }
    var path: String {
        switch self {
        case .fetchRMCharacters:
            return "\(ApiConstants.baseUrl)/character"
        }
    }
    var parameters: Parameters {
        switch self {
        case .fetchRMCharacters(let pageNumber):
            return [
                "page": pageNumber
            ]
        }
    }
}
