//
//  FirebaseManagerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
@testable import MeliProject

final class FirebaseManagerTests: XCTestCase {
    var mockLogger: MockLogger!
    var firebaseManager: FirebaseManager!
    
    override func setUp() {
        super.setUp()
        mockLogger = MockLogger()
        firebaseManager = FirebaseManager(logger: mockLogger)
    }
    
    func test_openScreen_logsCorrectly() {
        // When
        firebaseManager.openScreen(name: "Home")
        
        // Then
        let logged = mockLogger.loggedEvents.first
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(logged?.name, "screen_view")
    }
    
    func test_clickButton_logsWithNameOnly() {
        // When
        firebaseManager.clickButton(name: "Continue")
        
        // Then
        let logged = mockLogger.loggedEvents.first
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(logged?.name, "click_button")
        XCTAssertEqual(logged?.parameters?["button_name"] as? String, "Continue")
        XCTAssertNil(logged?.parameters?["screen"])
    }
    
    func test_clickButton_logsWithNameAndScreen() {
        // When
        firebaseManager.clickButton(name: "Continue", screen: "Login")
        
        // Then
        let logged = mockLogger.loggedEvents.first
        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(logged?.name, "click_button")
        XCTAssertEqual(logged?.parameters?["button_name"] as? String, "Continue")
        XCTAssertEqual(logged?.parameters?["screen"] as? String, "Login")
    }
    
    func test_errorReport_logsError() {
        let dummyError = NSError(domain: "Test", code: 123, userInfo: nil)
        firebaseManager.errorReport(error: dummyError, "While testing")
    }
}


final class MockLogger: AnalyticsLogging {
    var loggedEvents: [(name: String, parameters: [String: Any]?)] = []
    
    func logEvent(_ name: String, parameters: [String : Any]?) {
        loggedEvents.append((name, parameters))
    }
}
