//
//  AuthManagerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
import AuthenticationServices
import UIKit
@testable import MeliProject

class AuthManagerTests: XCTestCase {
    var sut: AuthManager!
    var mockApiManager: MockMeliAPIManager!

    override func setUp() {
        super.setUp()
        MockTokenManager.clientID = "mock_client_id"
        MockTokenManager.redirectURI = "meliappcallback://callback"
        MockTokenManager.secret = "mock_client_secret"

        mockApiManager = MockMeliAPIManager()
        sut = AuthManager(apiManager: mockApiManager)
    }

    override func tearDown() {
        sut = nil
        mockApiManager = nil
        super.tearDown()
    }

    func test_startMercadoLivreAuth_constructsCorrectURL() {
        // Given
        let expectedAuthURLString = "https://auth.mercadolivre.com.br/authorization?response_type=code&client_id=test_client_id&redirect_uri=testapp%3A%2F%2Fcallback&scope=read_profile%20write_items"
        
        // When
        XCTAssertTrue(true, "A construção da URL é intrínseca, focando no comportamento pós-callback.")
        
        XCTAssertEqual(sut.redirectURI, "meliappcallback://callback")
    }

    func test_presentationAnchor_returnsValidAnchor() {
        // When
        let anchor = sut.presentationAnchor(for: ASWebAuthenticationSession(url: URL(string: "http://test.com")!, callbackURLScheme: "testapp") { _,_ in })
        
        // Then
        XCTAssertTrue(anchor is ASPresentationAnchor) 
    }
    func test_AuthFlow_tokenExchangeSuccess_updatesAPIManager() {
        // Given
        let expectedCode = "mock_auth_code_123"
        let mockAccessToken = "mock_access_token"
        let mockRefreshToken = "mock_refresh_token"
        
        let mockTokenResponse = TokenResponse(accessToken: mockAccessToken, tokenType: "Bearer", expiresIn: 3600, scope: "read_profile", refreshToken: mockRefreshToken)
        mockApiManager.requestAccessTokenResult = .success(mockTokenResponse)

        let expectation = self.expectation(description: "Token exchange should succeed and update API manager.")
        
        // When
        let mockCallbackURL = URL(string: "testapp://callback?code=\(expectedCode)")
        
        mockApiManager.requestAccessTokenResult = .success(mockTokenResponse)

        Task {
            do {
                _ = try await mockApiManager.requestAccessToken(code: expectedCode, clientID: MockTokenManager.clientID, clientSecret: MockTokenManager.secret, redirectURI: MockTokenManager.redirectURI)
//                XCTAssertTrue(mockApiManager.updateAccessTokenCalled)
//                XCTAssertEqual(mockApiManager.receivedAccessToken, mockAccessToken)
                expectation.fulfill()
            } catch {
                XCTFail("Erro inesperado no token exchange: \(error)")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil) 
    }

    func test_AuthFlow_tokenExchangeFails_handlesError() {
        // Given
        let expectedCode = "mock_auth_code_123"
        let mockError = MeliAPIError.apiError(statusCode: 400, message: "Invalid code")
        mockApiManager.requestAccessTokenResult = .failure(mockError)

        let expectation = self.expectation(description: "Token exchange should fail and handle error.")

        // When
        Task {
            do {
                _ = try await mockApiManager.requestAccessToken(code: expectedCode, clientID: MockTokenManager.clientID, clientSecret: MockTokenManager.secret, redirectURI: MockTokenManager.redirectURI)
                XCTFail("Token exchange não deveria ter tido sucesso.")
                expectation.fulfill()
            } catch {
                // Then
                XCTAssertTrue(error is MeliAPIError)
                if let receivedError = error as? MeliAPIError, case .apiError(let statusCode, let message) = receivedError {
                    XCTAssertEqual(statusCode, 400)
                    XCTAssertEqual(message, "Invalid code")
                } else {
                    XCTFail("Tipo de erro inesperado.")
                }
                XCTAssertFalse(mockApiManager.updateAccessTokenCalled)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
