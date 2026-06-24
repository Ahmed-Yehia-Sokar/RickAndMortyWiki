//
//  ListCharactersViewModel.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

import Foundation

struct ListCharactersViewModelProvider {
    static func provide() -> ListCharactersViewModel {
        let usecase = ListCharactersUsecaseProvider.provide()
        return ListCharactersViewModel(usecase: usecase)
    }
}

@Observable
class ListCharactersViewModel {
    // MARK: - properties
    private let usecase: ListCharactersUsecaseContract
    private(set) var charactersList = [RMCharacter]()
    private(set) var errorMessage = ""
    var isLoadingNextPage: Bool {
        usecase.isLoading
    }
    
    // MARK: - public methods
    init(usecase: ListCharactersUsecaseContract) {
        self.usecase = usecase
    }
    
    func fetchCharacters() async {
        let result = await usecase.loadNextPage()
        switch result {
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .success(let charactersList):
            errorMessage = ""
            self.charactersList = charactersList
        }
    }

    func refresh() async {
        usecase.reset()
        await fetchCharacters()
    }

    func clearError() {
        errorMessage = ""
    }
}
