//
//  HomeRouterTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomeRouterTests: XCTestCase {
    var router: HomeRouter?
    
    override func setUp() {
        router = HomeRouter()
    }
    
    func test_setupCoordinator() {
        // Given
        let coordinator = MeliProjectCoordinator(with: UINavigationController())
        // When
        router?.setup(coordinator: coordinator)
        // Then
        XCTAssertNotNil(router?.coordinator)
    }
    
    func test_goToDetail() {
        // Given
        let coordinator = CoordinatorSpy()
        // When
        router?.setup(coordinator: coordinator)
        // Then
        router?.goToDetail(from: "")
        XCTAssertTrue(coordinator.didCalledStartDetail)
    }
}

