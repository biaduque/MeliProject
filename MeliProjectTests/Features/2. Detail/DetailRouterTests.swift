//
//  DetailRouterTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class DetailRouterTests: XCTestCase {
    var router: DetailRouter?
    
    override func setUp() {
        router = DetailRouter()
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
        router?.routeToBuyProduct(url: "")
        // Then
        XCTAssertTrue(coordinator.didCallBuyProduct)
    }
}

