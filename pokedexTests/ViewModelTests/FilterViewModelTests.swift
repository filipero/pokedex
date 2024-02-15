//
//  FilterViewModelTests.swift
//  PokedexTests
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import XCTest

@testable import Pokedex

final class FilterViewModelTests: XCTestCase {
    var sut: FilterViewModel!
    fileprivate var navigationDelegateSpy: FilterNavigationDelegateSpy!

    override func setUp() {
        super.setUp()
        navigationDelegateSpy = FilterNavigationDelegateSpy()
        sut = FilterViewModel(navigationDelegate: navigationDelegateSpy)
    }

    override func tearDown() {
        super.tearDown()
        navigationDelegateSpy = nil
        sut = nil
    }

    func test_whenScreenTitle_ShouldBeFilter() {
        XCTAssertEqual(sut.screenTitle, "Filter")
    }

    func test_whenGoToHomeScreen_ShouldBeCalled() {
        sut.goToHomeScreen(with: .electric)
        XCTAssertTrue(navigationDelegateSpy.goToHomeScreenCalled)
    }

    func test_whenGoToHomeScreen_ShouldCallCountBeOne() {
        sut.goToHomeScreen(with: .electric)
        XCTAssertEqual(navigationDelegateSpy.goToHomeScreenCallCount, 1)
    }

    func test_whenGoToHomeScreen_ShouldBePikachu() {
        sut.goToHomeScreen(with: .electric)
        XCTAssertEqual(navigationDelegateSpy.goToHomeScreenPokemonTypePassed, .electric)
    }
}

fileprivate class FilterNavigationDelegateSpy: FilterNavigationDelegate {
    private(set) var goToHomeScreenCalled: Bool = false
    private(set) var goToHomeScreenCallCount: Int = 0
    private(set) var goToHomeScreenPokemonTypePassed: Pokemon.Types?

    func goToHomeScreen(with type: Pokemon.Types) {
        goToHomeScreenCalled = true
        goToHomeScreenCallCount += 1
        goToHomeScreenPokemonTypePassed = type
    }
}
