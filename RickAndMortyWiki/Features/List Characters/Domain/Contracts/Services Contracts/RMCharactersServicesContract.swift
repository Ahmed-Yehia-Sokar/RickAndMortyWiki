//
//  RMCharactersServicesContract.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation

protocol RMCharactersServicesContract {
    func fetchRMCharacters(pageNumber: Int) async -> Result<[RMCharacter], Error>
}
