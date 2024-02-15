//
//  HomeViewModelTests.swift
//  PokedexTests
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import XCTest

@testable import Pokedex

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    fileprivate var serviceSpy: HomeWorkerSpy!
    fileprivate var homeNavigationDelegateSpy: HomeNavigationDelegateSpy!
    
    override func setUp() {
        super.setUp()
        serviceSpy = HomeWorkerSpy()
        homeNavigationDelegateSpy = HomeNavigationDelegateSpy()
        sut = HomeViewModel(service: serviceSpy, navigationDelegate: homeNavigationDelegateSpy)
    }

    override func tearDown() {
        super.tearDown()
        serviceSpy = nil
        homeNavigationDelegateSpy = nil
        sut = nil
    }

    func test_whenScreenTitle_ShouldBePokemon() {
        XCTAssertEqual(sut.screenTitle, "Pokemon")
    }

    func test_WhenGoToFilterScreen_ShouldBeCalled() {
        sut.goToFilterScreen()
        XCTAssertTrue(homeNavigationDelegateSpy.goToFilterScreenCalled)
    }

    func test_WhenGoToFilterScreen_ShouldCallCountBeOne() {
        sut.goToFilterScreen()
        XCTAssertEqual(homeNavigationDelegateSpy.goToFilterScreenCallCount, 1)
    }

    func test_whenGoToDetailsScreen_ShouldBeCalled() {
        sut.goToDetailsScreen(character: .stub())
        XCTAssertTrue(homeNavigationDelegateSpy.goToDetailScreenCalled)
    }

    func test_whenGoToDetailsScreen_ShouldCallCountBeOne() {
        sut.goToDetailsScreen(character: .stub())
        XCTAssertEqual(homeNavigationDelegateSpy.goToDetailScreenCallCount, 1)
    }

    func test_whenGoToDetailsScreen_ShouldBePikachu() {
        sut.goToDetailsScreen(character: .stub())
        XCTAssertEqual(homeNavigationDelegateSpy.goToDetailScreenCharacterPassed?.id, "25")
        XCTAssertEqual(homeNavigationDelegateSpy.goToDetailScreenCharacterPassed?.url, "https://pokeapi.co/api/v2/pokemon/25")
        XCTAssertEqual(homeNavigationDelegateSpy.goToDetailScreenCharacterPassed?.name, "pikachu")
    }

    func test_GivenFilterNil_WhenGetMoreCharacters_ShouldBeCalled() {
        sut.getMoreCharacters(filter: nil)
        XCTAssertTrue(serviceSpy.getPokemonListCalled)
    }

    func test_GivenFilterNil_WhenGetMoreCharacters_ShouldCallCountBeOne() {
        sut.getMoreCharacters(filter: nil)
        XCTAssertEqual(serviceSpy.getPokemonListCallCount, 1)
    }

    func test_GivenFilterElectric_WhenGetMoreCharacters_ShouldBeCalled() {
        sut.getMoreCharacters(filter: .electric)
        XCTAssertTrue(serviceSpy.getPokemonListByTypeCalled)
    }

    func test_GivenFilterElectric_WhenGetMoreCharacters_ShouldCallCountBeOne() {
        sut.getMoreCharacters(filter: .electric)
        XCTAssertEqual(serviceSpy.getPokemonListByTypeCallCount, 1)
    }
}

extension PokemonListItem {
    static func stub(id: String = "25", url: String = "https://pokeapi.co/api/v2/pokemon/25", name: String = "pikachu") -> PokemonListItem {
        .init(id: id, url: url, name: name)
    }
}

fileprivate class HomeWorkerSpy: HomeWorkerProtocol {
    private(set) var getPokemonListCalled: Bool = false
    private(set) var getPokemonListCallCount: Int = 0

    private(set) var getPokemonListByTypeCalled: Bool = false
    private(set) var getPokemonListByTypeCallCount: Int = 0
    func getPokemonList(request: Pokedex.PokemonListRequest, result: @escaping ([Pokedex.PokemonListItem]?, Error?) -> ()) {
        getPokemonListCalled = true
        getPokemonListCallCount += 1
    }

    func getPokemonListByType(request: Pokedex.PokemonListByTypeRequest, result: @escaping ([Pokedex.PokemonListItem]?, Error?) -> ()) {
        getPokemonListByTypeCalled = true
        getPokemonListByTypeCallCount += 1
    }
}

fileprivate class HomeNavigationDelegateSpy: HomeNavigationDelegate {
    private(set) var goToDetailScreenCalled: Bool = false
    private(set) var goToDetailScreenCallCount: Int = 0
    private(set) var goToDetailScreenCharacterPassed: PokemonListItem?

    private(set) var goToFilterScreenCalled: Bool = false
    private(set) var goToFilterScreenCallCount: Int = 0

    func goToDetailScreen(character: PokemonListItem) {
        goToDetailScreenCalled = true
        goToDetailScreenCallCount += 1
        goToDetailScreenCharacterPassed = character
    }

    func goToFilterScreen() {
        goToFilterScreenCalled = true
        goToFilterScreenCallCount += 1
    }
}
