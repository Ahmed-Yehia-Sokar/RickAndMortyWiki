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
    
    var method: String {
        switch self {
        case .fetchRMCharacters:
            return HTTPMethod.get.rawValue
        }
    }
    var path: String {
        switch self {
        case .fetchRMCharacters:
            return "\(ApiConstants.baseUrl)/character"
        }
    }
    var parameters: [String: Any] {
        switch self {
        case .fetchRMCharacters(let pageNumber):
            return [
                "page": pageNumber
            ]
        }
    }
}
