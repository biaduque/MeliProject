//
//  HomeInteractorTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
import RxSwift
import RxBlocking
@testable import RxTest
@testable import MeliProject

class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!
    var mockWorker: HomeWorker!
    var mockPresenter: HomePresenterSpy!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        mockWorker = HomeWorker()
        mockPresenter = HomePresenterSpy()
        sut = HomeInteractor()
        sut.setup(worker: mockWorker, presenter: mockPresenter)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        sut = nil
        mockWorker = nil
        mockPresenter = nil
        disposeBag = nil
        scheduler = nil
        super.tearDown()
    }

    func test_setup_setsWorkerAndPresenter() {
        // Then
        XCTAssertNotNil(sut.worker)
        XCTAssertNotNil(sut.presenter)
        XCTAssertTrue(sut.worker is HomeWorker)
        XCTAssertTrue(sut.presenter is HomePresenterSpy)
    }

    // MARK: - fetchItemList(search:page:)
    func test_fetchItemList() {
        // Given
        let testSearchTerm = "iphone"
        let testPage = "1"
        let mockItems = [
            Item(id: "1", title: "iPhone 13", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 100, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil),
            Item(id: "2", title: "Samsung Galaxy", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 200, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        let mockSearchResult = SearchResult(siteID: "MLB", query: testSearchTerm, paging: Paging(total: 2, primaryResults: 2, offset: 0, limit: 2), results: mockItems, sort: nil, availableSorts: nil, filters: nil, availableFilters: nil)
        
        // When
        sut.fetchItemList(search: testSearchTerm, page: testPage)
        scheduler.start()
        
        // Then
        XCTAssertTrue(mockPresenter.didCall)
    }

    func test_fetchItemList_whenWorkerReturnsSuccessAndNoItemsFound_presentsEmptyView() {
        // Given
        let testSearchTerm = "nonexistent"
        let testPage = "1"
        let mockSearchResult = SearchResult(siteID: "MLB", query: testSearchTerm, paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [], sort: nil, availableSorts: nil, filters: nil, availableFilters: nil)
        

        // When
        sut.fetchItemList(search: testSearchTerm, page: testPage)
        scheduler.start()
        
        // Then
        XCTAssertTrue(mockPresenter.didCall)
    }
    
    func test_fetchItemList_whenWorkerReturnsError_presentsError() {
        // Given
        let testSearchTerm = "any"
        let testPage = "1"
        let mockError = MeliAPIError.networkError(NSError(domain: "Test", code: 100, userInfo: nil))
        
        // When
        sut.fetchItemList(search: testSearchTerm, page: testPage)
        scheduler.start()
        
        // Then
        XCTAssertTrue(mockPresenter.didCall)
    }
    
    // MARK: - Testes para checkIfExists(query:items:)

    func test_checkIfExists_whenItemExists_returnsTrue() {
        // Given
        let query = "fone"
        let items = [
            Item(id: "1", title: "Fone de ouvido", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil),
            Item(id: "2", title: "Mouse sem fio", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        
        // When
        let exists = sut.checkIfExists(query: query, items: items)
        
        // Then
        XCTAssertTrue(exists)
    }

    func test_checkIfExists_whenItemDoesNotExist_returnsFalse() {
        // Given
        let query = "teclado"
        let items = [
            Item(id: "1", title: "Fone de ouvido", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil),
            Item(id: "2", title: "Mouse sem fio", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        
        // When
        let exists = sut.checkIfExists(query: query, items: items)
        
        // Then
        XCTAssertFalse(exists)
    }
    
    func test_checkIfExists_whenItemsArrayIsEmpty_returnsFalse() {
        // Given
        let query = "qualquer"
        let items: [Item] = []
        
        // When
        let exists = sut.checkIfExists(query: query, items: items)
        
        // Then
        XCTAssertFalse(exists)
    }

    // MARK: - Testes para filterItemsByTitle(searchText:in:)

    func test_filterItemsByTitle_returnsOnlyMatchingItems() {
        // Given
        let searchText = "fone"
        let items = [
            Item(id: "1", title: "Fone de ouvido Bluetooth", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil),
            Item(id: "2", title: "Mouse sem fio", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil),
            Item(id: "3", title: "Fone com fio", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        
        // When
        let filteredItems = sut.filterItemsByTitle(searchText: searchText, in: items)
        
        // Then
        XCTAssertEqual(filteredItems.count, 2)
        XCTAssertTrue(filteredItems.contains(where: { $0.id == "1" }))
        XCTAssertTrue(filteredItems.contains(where: { $0.id == "3" }))
        XCTAssertFalse(filteredItems.contains(where: { $0.id == "2" }))
    }

    func test_filterItemsByTitle_isCaseInsensitive() {
        // Given
        let searchText = "FOne"
        let items = [
            Item(id: "1", title: "fone de ouvido", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        
        // When
        let filteredItems = sut.filterItemsByTitle(searchText: searchText, in: items)
        
        // Then
        XCTAssertEqual(filteredItems.count, 1)
        XCTAssertTrue(filteredItems.first?.id == "1")
    }

    func test_filterItemsByTitle_returnsEmptyArray_whenNoMatches() {
        // Given
        let searchText = "naoexiste"
        let items = [
            Item(id: "1", title: "Fone de ouvido", condition: nil, thumbnailID: nil, catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil, siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil, price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil, soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil, shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil, pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil)
        ]
        
        // When
        let filteredItems = sut.filterItemsByTitle(searchText: searchText, in: items)
        
        // Then
        XCTAssertTrue(filteredItems.isEmpty)
    }
    
    func test_filterItemsByTitle_returnsEmptyArray_whenItemsArrayIsEmpty() {
        // Given
        let searchText = "qualquer"
        let items: [Item] = []
        
        // When
        let filteredItems = sut.filterItemsByTitle(searchText: searchText, in: items)
        
        // Then
        XCTAssertTrue(filteredItems.isEmpty)
    }
}
