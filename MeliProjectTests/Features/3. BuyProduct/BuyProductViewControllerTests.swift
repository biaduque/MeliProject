//
//  BuyProductViewControllerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//



import XCTest
@testable import MeliProject

class BuyProductViewControllerTests: XCTestCase {
    var controller: BuyProductViewController?
    var interactorSpy: BuyProductInteractorSpy?
    
    override func setUp() {
        controller = BuyProductFactory.makeController(with: "https://www.apple.com") as? BuyProductViewController
        interactorSpy = BuyProductInteractorSpy()
        
        controller?.setup(interactor: interactorSpy!)
        controller?.loadView()
        controller?.viewDidLoad()
    }
    
    func test_initWithCoder() {
        // Given
        let coder = NSCoder()
        // When
        let controller = BuyProductViewController(coder: coder)
        let view = BuyProductView(coder: coder)
        // Then
        XCTAssertNil(controller)
        XCTAssertNil(view)
    }
    
    func test_loadWebView() {
        // Given
        guard let interactorSpy = interactorSpy else {
            XCTFail()
            return
        }
        
        // When
        controller?.loadWebView()
        
        // Then
        XCTAssertTrue(interactorSpy.getWebViewCalled)
    }
    
    func test_webView() {
        // Given
        let error = NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "Url not found"])
        guard let controller = controller else {
            XCTFail()
            return
        }
        
        // When
        controller.webView(controller.webView.webView, didFinish: .none)
        controller.webView(controller.webView.webView, didFail: .none, withError: error)
        
        // Then
        XCTAssertTrue(controller.webView.loadingView.message.isHidden)
    }
}
