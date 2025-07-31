//
//  HomePresenteTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import XCTest
@testable import MeliProject

class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter?
    var controller: HomeViewController?

    override func setUp() {
        presenter = HomePresenter()
        controller = HomeFactory.makeController(with: MeliProjectCoordinator(with: UINavigationController()),
                                                aditionalInfos: nil) as? HomeViewController

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
    
    func test_presentiInitialView() {
        presenter?.presentiInitialView()
       
        XCTAssertNotNil(presenter?.controller)
    }
    
    func test_presentItemsList() {
        presenter?.presentItemsList(content: SearchResultMock.mockSearchResults())
        
        XCTAssertNotNil(presenter?.controller)
    }
    
    func test_presentFunctions() {
        presenter?.presentEmptyView()
        presenter?.presentError()
        presenter?.hideLoading()
        presenter?.presentLoading()
        presenter?.updateView()
        
        XCTAssertNotNil(presenter?.controller)
    }
    
   
}
