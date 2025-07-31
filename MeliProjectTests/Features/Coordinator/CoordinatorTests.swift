//
//  CoordinatorTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import MeliProject

class CoordinatorTests: XCTestCase {
    var coordinator: MeliProjectCoordinator?
    
    override func setUp() {
        coordinator = MeliProjectCoordinator(with: UINavigationController())
        coordinator!.journeyTypes = AppJourneys(home: .native, detail: .native, buyProduct: .webview)
    }
    
    func test_startDetail() {
        // Given
        guard let coordinator = coordinator else {
            XCTFail()
            return
        }
        // When
        coordinator.startDetail(with: "mock-id")
        
        // Then
        XCTAssertNotNil(coordinator.navigationController)
    }
    
    func test_back() {
        // Given
        guard let coordinator = coordinator else {
            XCTFail()
            return 
        }
        // When
        coordinator.back()
        
        // Then
        XCTAssertNil(coordinator.navigationController.popoverPresentationController)
    }
    
    func test_startBuyProduct() {
        // Given
        guard let coordinator = coordinator else {
            XCTFail()
            return
        }
        
        let mockURL = "https://mercadolivre.com.br"
        coordinator.journeyTypes = AppJourneys(home: .native, detail: .native, buyProduct: .webview)
        
        // When
        coordinator.startBuyProduct(with: mockURL)
        
        // Then
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 1)
        XCTAssertTrue(coordinator.navigationController.topViewController is BuyProductViewController)
    }
}

class CoordinatorSpy: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    var didCalledStart = false
    var didCalledStartDetail = false
    var didCalledBack = false
    var didCallBuyProduct = false
    
    func start() {
        didCalledStart = true
    }
    
    func startDetail(with requestId: String) {
        didCalledStartDetail = true
    }
    
    func startBuyProduct(with url: String) {
        didCallBuyProduct = true
    }
    
    func back() {
        didCalledBack = true
    }
}
