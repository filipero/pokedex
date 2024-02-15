//
//  DetailsViewModelTests.swift
//  PokedexTests
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import XCTest

@testable import Pokedex

final class DetailsViewModelTests: XCTestCase {
    var sut: DetailsViewModel!
    fileprivate var serviceSpy: WorkerSpy!

    override func setUp() {
        super.setUp()
        serviceSpy = WorkerSpy()
        sut = DetailsViewModel(service: serviceSpy, pokemonName: "pikachu")
    }

    override func tearDown() {
        super.tearDown()
        serviceSpy = nil
        sut = nil
    }

    func test_whenScreenTitle_ShouldBePikachu() {
        XCTAssertEqual(sut.screenTitle, "Pikachu")
    }

    func test_whenGoToHomeScreen_ShouldBeCalled() {
        sut.getPokemonData(completion: { _ in })
        XCTAssertTrue(serviceSpy.getPokemonDetailsCalled)
    }

    func test_whenGoToHomeScreen_ShouldCallCountBeOne() {
        sut.getPokemonData(completion: { _ in })
        XCTAssertEqual(serviceSpy.getPokemonDetailsCallCount, 1)
    }
}

fileprivate class WorkerSpy: DetailsWorkerProtocol {
    private(set) var getPokemonDetailsCalled: Bool = false
    private(set) var getPokemonDetailsCallCount: Int = 0

    func getPokemonDetails(request: DetailsRequest, result: @escaping (Pokemon?, Error?) -> ()) {
        getPokemonDetailsCalled = true
        getPokemonDetailsCallCount += 1

    }
}
