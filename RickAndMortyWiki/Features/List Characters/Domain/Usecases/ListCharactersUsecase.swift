//
//  ListCharactersUsecase.swift
//  RickAndMortyWiki
//
//  Created by Admin on 23/06/2026.
//

struct ListCharactersUsecaseProvider {
    static func provide() -> ListCharactersUsecase {
        let services = RMCharactersServicesProvider.provide()
        return ListCharactersUsecase(services: services)
    }
}

class ListCharactersUsecase: ListCharactersUsecaseContract {
    // MARK: - properties
    private let services: RMCharactersServicesContract
    private var loadedCharacters = [RMCharacter]()
    private var currentPage = 0
    private var hasNextPage = true
    private(set) var isLoading = false

    // MARK: - public methods
    init(services: RMCharactersServicesContract) {
        self.services = services
    }

    func loadNextPage() async -> Result<[RMCharacter], Error> {
        guard !isLoading, hasNextPage else {
            return .success(loadedCharacters)
        }

        isLoading = true
        defer {
            isLoading = false
        }

        let nextPage = currentPage + 1
        let result = await services.fetchRMCharacters(pageNumber: nextPage)

        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let newCharacters):
            if newCharacters.isEmpty {
                hasNextPage = false
            } else {
                loadedCharacters.append(contentsOf: newCharacters)
                currentPage = nextPage
            }
            return .success(loadedCharacters)
        }
    }
    
    func reset() {
        loadedCharacters.removeAll()
        currentPage = 0
        hasNextPage = true
        isLoading = false
    }
}
