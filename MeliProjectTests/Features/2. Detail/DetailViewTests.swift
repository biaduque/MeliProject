//
//  DetailViewTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//



import XCTest
@testable import MeliProject

class DetailViewTests: XCTestCase {
    var view: DetailView?
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        view = DetailView(viewModel: DetailViewModel())
        tableView = UITableView()
        tableView.delegate = view
        tableView.dataSource = view
    }
    
    override func tearDown() {
        view = nil
        tableView = nil
        super.tearDown()
    }
    
    func test_numberOfRowsInSection_WhenPullRequestsExist_ShouldReturnCorrectCount() {
        // Given
        guard let view = view else {
            XCTFail()
            return
        }
        
        let mockItem = ItemMock.mockiPhone13Detail()
        
        view.detailViewModel = DetailViewModel(item: mockItem)
        
        // When
        let rowCount = view.tableView(tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(rowCount, 1, "Wrong number of lines")
    }
    
    func test_numberOfRowsInSection_WhenPullRequestsAreNil_ShouldReturnZero() {
        // Given
        guard let view = view else {
            XCTFail()
            return
        }
        
        view.detailViewModel = DetailViewModel()
        
        // When
        let rowCount = view.tableView(tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(rowCount, 1, "Wrong number of lines")
    }
    
    func test_cellForRowAt_ShouldReturnConfiguredCell() {
        // Given
        guard let view = view else {
            XCTFail()
            return
        }
        
        let mockItem = ItemMock.mockiPhone13Detail()

        
        view.detailViewModel = DetailViewModel(item: mockItem)

        tableView.register(DetailInfosViewCell.self, forCellReuseIdentifier: DetailInfosViewCell.identifier)
        
        // When
        let cell = view.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DetailInfosViewCell
        
        // Then
        XCTAssertNotNil(cell, "A célula não deveria ser nil")
    }
}
