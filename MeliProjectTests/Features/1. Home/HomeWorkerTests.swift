//
//  HomeWorkerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
@testable import MeliProject
@testable import RxSwift
@testable import RxBlocking

class HomeWorkerTests: XCTestCase {
    var sut: HomeWorker!
    var mockSession: URLSessionMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        sut = HomeWorker()
        sut.session = mockSession
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        disposeBag = nil
        super.tearDown()
    }
    
    
    func test_fetchSearchResult() {
        // Given
        let jsonString = MeliAPIManager.loadFileContent(from: "content_response", withExtension: "json")!
        mockSession.data = jsonString.data(using: .utf8)
        
        // When
        let observable = sut.getItemList(searchedItem: "iphone", page: "1")
        let result = try? observable.first()
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func test_fetchSearchResult_withError() {
        // Given
        mockSession.error = NSError(domain: "Test", code: 500, userInfo: nil)
        
        // When
        let observable = sut.getItemList(searchedItem: "iphone", page: "1")
        var receivedError: Error?
        do {
            _ = try observable.first()
        } catch {
            receivedError = error
        }
        
        // Then
        XCTAssertNil(receivedError)
    }
    
    func test_getItemListSuccess() {
        // Given
        let jsonString = MeliAPIManager.loadFileContent(from: "content_response", withExtension: "json")!
        mockSession.data = jsonString.data(using: .utf8)
        
        // When
        let result = try? sut.getItemList(searchedItem: "mock", page: "1")
            .first()
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func test_getItemListInvalidRequest() {
        // Given
        // Forçando um retorno inválido de request
        let builder = ItemRequestBuilder.self
        let originalMethod = builder.configuteRequest
        
        // When
        let observable = sut.getItemList(searchedItem: "mock", page: "1")
        let result = try? observable
            .materialize()
            .first()
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func test_mockJsonSearchResult_successfullyDecodes() {
        // When
        let result = sut.mockJsonSearchResult()
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertTrue(result is SearchResult)
        XCTAssertGreaterThan(result?.results.count ?? 0, 0)
    }
}
