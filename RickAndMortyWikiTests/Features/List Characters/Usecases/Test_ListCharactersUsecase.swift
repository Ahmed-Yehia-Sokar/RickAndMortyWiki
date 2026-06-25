//
//  Test_ListCharactersUsecase.swift
//  Test_ListCharactersUsecase
//
//  Created by Admin on 23/06/2026.
//

import XCTest
@testable import RickAndMortyWiki

final class Test_ListCharactersUsecase: XCTestCase {
    private var services: MockServices!
    private var sut: ListCharactersUsecase!

    override func setUp() {
        super.setUp()
        services = MockServices()
        sut = ListCharactersUsecase(services: services)
    }

    func test_loadNextPage_onSuccess_returnsCharacters() async {
        services.result = .success([rick])

        let result = await sut.loadNextPage()

        XCTAssertEqual(try? result.get(), [rick])
        XCTAssertEqual(services.requestedPages, [1])
    }

    func test_loadNextPage_onFailure_returnsError() async {
        services.result = .failure(DummyError.any)

        let result = await sut.loadNextPage()

        if case .success = result { XCTFail("Expected failure") }
    }

    func test_loadNextPage_calledTwice_appendsAndIncrementsPage() async {
        services.result = .success([rick])
        _ = await sut.loadNextPage()

        services.result = .success([morty])
        let result = await sut.loadNextPage()

        XCTAssertEqual(try? result.get(), [rick, morty])
        XCTAssertEqual(services.requestedPages, [1, 2])
    }

    func test_loadNextPage_onEmptySuccess_stopsCallingService() async {
        services.result = .success([])
        _ = await sut.loadNextPage()

        _ = await sut.loadNextPage()

        XCTAssertEqual(services.requestedPages, [1])
    }

    func test_reset_startsFromPageOneAgain() async {
        services.result = .success([rick])
        _ = await sut.loadNextPage()

        sut.reset()
        _ = await sut.loadNextPage()

        XCTAssertEqual(services.requestedPages, [1, 1])
    }

    private let rick = RMCharacter(image: "", name: "Rick", gender: "", status: "", species: "", origin: "", location: "", episodes: [])
    private let morty = RMCharacter(image: "", name: "Morty", gender: "", status: "", species: "", origin: "", location: "", episodes: [])
}

private enum DummyError: Error { case any }

private final class MockServices: RMCharactersServicesContract {
    var result: Result<[RMCharacter], Error> = .success([])
    private(set) var requestedPages: [Int] = []

    func fetchRMCharacters(pageNumber: Int) async -> Result<[RMCharacter], Error> {
        requestedPages.append(pageNumber)
        return result
    }
}
