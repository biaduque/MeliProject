//
//  DetailPresenterTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class DetailPresenterTests: XCTestCase {
    var presenter: DetailPresenter?
    var controller: DetailViewController?
    var mockInfos = DetailRequestBuilder()

    override func setUp() {
        presenter = DetailPresenter()
        controller = DetailFactory.makeController(with: MeliProjectCoordinator(with: UINavigationController()), aditionalInfos: "") as! DetailViewController?

        presenter?.setup(controller: controller!)
    }
    func test_setupController() {
        // Given
        let controller = controller
        // When
        presenter?.setup(controller: controller!)
        // Then
        XCTAssertNotNil(presenter?.controller)
    }
    
    func test_presentFunctions() {                
        presenter?.presentDetail(content: ItemMock.mockiPhone13Detail())
        presenter?.presentEmptyView()
        presenter?.presentError()
        presenter?.presentLoading()
        presenter?.updateView()
        
        XCTAssertNotNil(presenter?.controller)
    }
}
