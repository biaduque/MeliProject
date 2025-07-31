//
//  BuyProductInteractorTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
@testable import MeliProject

class BuyProductInteractorTests: XCTestCase {
    var interactor: BuyProductInteractor?
    
    override func setUp() {
        interactor = BuyProductInteractor()
    }
    
    func test_getWebView() {
        // Given
        guard let interactor = interactor else {
            XCTFail()
            return
        }
        // When
        interactor.getWebView({ response in
            // Then
            XCTAssertTrue(true )
        }, url: "https://apple.com.br")
    }
}

