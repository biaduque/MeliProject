//
//  DetailViewControllerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import MeliProject

class DetailViewControllerTests: XCTestCase {
    var controller: DetailViewController?
    var mockInfos = "mock-id"
    var presenterSpy: DetailPresenterSpy?
    var routerSpy: DetailRouterSpy?
    var interactorSpy: DetailInteractorSpy?
    var authManagerSpy: AuthManager?
    
    override func setUp() {
        controller = DetailFactory.makeController(with: MeliProjectCoordinator(with: UINavigationController()), aditionalInfos: mockInfos) as! DetailViewController?
        presenterSpy = DetailPresenterSpy()
        routerSpy = DetailRouterSpy()
        interactorSpy = DetailInteractorSpy()
        authManagerSpy = AuthManager(apiManager: MeliAPIManager(accessToken: ""))
 
        presenterSpy?.setup(controller: controller!)
        controller?.setup(auth: authManagerSpy!)
        controller?.setup(router: routerSpy!)
        controller?.setup(interactor: interactorSpy!)
        
        controller?.loadView()
        controller?.viewDidLoad()
    }
    
    func test_initWithCoder() {
        // Given
        let coder = NSCoder()
        // When
        let controller = DetailViewController(coder: coder)
        let view = DetailView(coder: coder)
        // Then
        XCTAssertNil(controller)
        XCTAssertNil(view)
    }
    
    func test_contentControllerProtocol() {
        // Given
        guard let presenterSpy = presenterSpy else {
            XCTFail()
            return
        }
        
        // When
        presenterSpy.presentEmptyView()
        presenterSpy.presentError()
        presenterSpy.presentLoading()
        presenterSpy.updateView()
        presenterSpy.hideLoading()
        presenterSpy.presentDetail(content: ItemMock.mockiPhone13Detail())
        
        // Then
        XCTAssertTrue(presenterSpy.didCall)
        XCTAssertTrue(presenterSpy.didCallPresentDetail)
    }
    
    func test_shareButtonTapped() {
        // Given
        controller?.setupContent(with: ItemMock.mockiPhone13Detail())
        // When
        controller?.shareButtonTapped()
        
        // Then
        XCTAssertNotNil(controller?.urlItem)
    }
    
    func test_cartButtonTapped() {
        // Given
        guard let routerSpy = routerSpy else {
            XCTFail()
            return
        }
        
        // When
        controller?.cartButtonTapped()
        
        // Then
        XCTAssertTrue(routerSpy.routeToBuyProductCalled)
    }

    func test_repositoryViewCell() {
        // Given
        let cell = DetailInfosViewCell(style: .default, reuseIdentifier: DetailInfosViewCell.identifier)
        
        // When
        cell.setupView()
        cell.setupContent(itemIcon: "star.fill", itemInfo: "mock-content")
        // Then
        XCTAssertEqual(cell.itemInfo.text, "mock-content")
    }
}
