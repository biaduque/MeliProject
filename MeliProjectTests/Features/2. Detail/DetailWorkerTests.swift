//
//  DetailWorkerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import RxSwift
@testable import MeliProject

class DetailWorkerTests: XCTestCase {
    var sut: DetailWorker!
    var mockSession: URLSessionMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        sut = DetailWorker()
        sut.session = mockSession
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        sut = nil
        mockSession = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_getRepoList() {
        // Given
        let jsonString = MeliAPIManager.loadFileContent(from: "detail_response", withExtension: "json")!
        mockSession.data = jsonString.data(using: .utf8)
        
        let request = DetailRequestBuilder()

        // When
        let result = try? sut.getDetail(with: "mock-item")
            .first()
        
        // Then
        XCTAssertNotNil(result)
    }

    func test_getRepoListNoRequest() {
        // Given
        let request = DetailRequestBuilder()
        
        // When
        let result = sut.getDetail(with: "mock-item")
            .materialize()
        
        // Then
        XCTAssertNotNil(result)
    }
}
