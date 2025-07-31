//
//  HomeViewControllerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import MeliProject

class HomeViewControllerTests: XCTestCase {
    var controller: HomeViewController?
    var presenterSpy: HomePresenterSpy?
    var delegateSpy: HomeViewDelegateSpy?
    var routerSpy: HomeRouterSpy?
    var interactorSpy: HomeInteractorSpy?
    
    override func setUp() {
        controller = HomeFactory.makeController(with: MeliProjectCoordinator(with: UINavigationController()), aditionalInfos: nil) as! HomeViewController?
        presenterSpy = HomePresenterSpy()
        delegateSpy = HomeViewDelegateSpy()
        routerSpy = HomeRouterSpy()
        interactorSpy = HomeInteractorSpy()
        
        controller?.styleView?.delegate = delegateSpy
        controller?.setup(router: routerSpy!)
        controller?.setup(interactor: interactorSpy!)
        presenterSpy?.setup(controller: controller!)
    }
    
    func test_initWithCoder() {
        // Given
        let coder = NSCoder()
        // When
        let controller = HomeViewController(coder: coder)
        let view = HomeView(coder: coder)
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
        presenterSpy.presentItemsList(content:  SearchResultMock.mockSearchResults())
        
        // Then
        XCTAssertTrue(presenterSpy.didCall)
        XCTAssertEqual(presenterSpy.content?.results[0].id, "MLB1234567890")
        
    }
    
    func test_didCallSelectRepository() {
        // Given
        guard let delegateSpy = delegateSpy else {
            XCTFail()
            return
        }
        // When
        controller?.styleView?.delegate?.didSelectItem(id: "mock-item")
        
        // Then
        XCTAssertTrue(delegateSpy.didCallSelectedItem)
        XCTAssertEqual(delegateSpy.id, "mock-item")

    }
    
    func test_didCallRequestedNextPage() {
        // Given
        guard let delegateSpy = delegateSpy else {
            XCTFail()
            return
        }
        // When
        controller?.styleView?.delegate?.didRequestedNextPage()
        
        // Then
        XCTAssertTrue(delegateSpy.didCallNextPage)
    }
    
    
    func test_didSelectRepository() {
        // Given
        guard let routerSpy = routerSpy else {
            XCTFail()
            return
        }
        
        // When
        controller?.didSelectItem(id: "")
        
        // Then
        XCTAssertTrue(routerSpy.calledGoToDetail)
    }
    
    func test_fetchRepoList() {
        // Given
        guard let interactorSpy = interactorSpy else {
            XCTFail()
            return
        }
        
        // When
        controller?.didRequestedNextPage()
        
        // Then
        XCTAssertTrue(interactorSpy.fetchItemListCalled)
    }
    
    func test_homeView() {
        // Given
        let mockContent = SearchResultMock.mockSearchResults()
        
        // When
        let view = HomeView(viewModel: HomeViewModel())
        view.setup(content: mockContent)
        
        // Then
        XCTAssertEqual(view.homeViewModel.searchResult?.siteID, mockContent.siteID)
    }
    
    func test_searchField() {
        // Given
        let seatchField = SearchTextFieldView()
        seatchField.state = .topViewSearch
        
        // When
        seatchField.setupConstraintsForSearch()
        
        // Then
        XCTAssertNotNil(seatchField.snp.height)
    }
    
    func test_searchFieldChanged() {
        // Given
        let seatchField = SearchTextFieldView()
        seatchField.state = .topViewSearch
        
        // When
        seatchField.searchChanged(UITextField())
        
        // Then
        XCTAssertNotNil(seatchField.snp.height)
    }
    
    func test_searchFieldHide() {
        // Given
        let seatchField = SearchTextFieldView()
        seatchField.state = .initialSearch
        
        // When
        seatchField.hide()
        seatchField.dismissKeyboard()
        
        // Then
        XCTAssertNotNil(seatchField.endEditing(true))
    }
    
    func test_homeViewConstraints() {
        // Given
        let mockContent = SearchResultMock.mockSearchResults()
        
        // When
        let view = HomeView(viewModel: HomeViewModel())
        view.setup(content: mockContent)
        view.setupSearchingConstraints()
        
        // Then
        XCTAssertFalse(view.contentTableView.isHidden)
    }
    
    func test_itemViewCell() {
        // Given
        let view = ItemInfosView()
        let cell = ItemViewCell(style: .default, reuseIdentifier: ItemViewCell.identifier)
        
        // When
        view.itemName.text = "mock_name"
        cell.setupView()
        cell.setupContent(itemName: view.itemName.text ?? "", value: "", payment: "")
        
        // Then
        XCTAssertEqual(cell.itemInfos.itemName.text, "mock_name")
    }
}
