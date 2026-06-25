//
//  Test_CharacterDetailsUsecase.swift
//  RickAndMortyWiki
//
//  Created by Admin on 25/06/2026.
//

import XCTest
@testable import RickAndMortyWiki

final class Test_CharacterDetailsUsecase: XCTestCase {
    private var services: MockServices!
    private var sut: CharacterDetailsUsecase!

    override func setUp() {
        super.setUp()
        services = MockServices()
        sut = CharacterDetailsUsecase(services: services)
    }

    func test_fetchEpisodes_onSuccess_returnsEpisodes() async {
        services.result = .success([pilot])

        let result = await sut.fetchEpisodes(from: ["https://rickandmortyapi.com/api/episode/1"])

        XCTAssertEqual(try? result.get(), [pilot])
    }

    func test_fetchEpisodes_onFailure_returnsError() async {
        services.result = .failure(DummyError.any)

        let result = await sut.fetchEpisodes(from: ["https://rickandmortyapi.com/api/episode/1"])

        if case .success = result { XCTFail("Expected failure") }
    }

    func test_fetchEpisodes_forwardsURLsToService() async {
        let urls = ["https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"]

        _ = await sut.fetchEpisodes(from: urls)

        XCTAssertEqual(services.receivedURLs, urls)
    }

    private let pilot = Episode(name: "Pilot", airDate: "December 2, 2013", code: "S01E01")
}

private enum DummyError: Error { case any }

private final class MockServices: CharacterDetailsServicesContract {
    var result: Result<[Episode], Error> = .success([])
    private(set) var receivedURLs: [String] = []

    func fetchEpisodes(from urls: [String]) async -> Result<[Episode], Error> {
        receivedURLs = urls
        return result
    }
}
