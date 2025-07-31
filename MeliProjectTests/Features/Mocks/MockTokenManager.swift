//
//  MockTokenManager.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
import AuthenticationServices
@testable import MeliProject

// MARK: - Mocks para Testes

class MockTokenManager {
    static var clientID: String = "mock_client_id"
    static var redirectURI: String = "mockapp://callback"
    static var secret: String = "mock_client_secret"
}

class MockMeliAPIManager: MeliAPIManagerProtocol {
    var requestAccessTokenResult: Result<TokenResponse, Error>?
    var updateAccessTokenCalled = false
    var receivedAccessToken: String?

    func requestAccessToken(code: String, clientID: String, clientSecret: String, redirectURI: String) async throws -> MeliProject.TokenResponse {
        if let result = requestAccessTokenResult {
            switch result {
            case .success(let tokenResponse):
                return tokenResponse
            case .failure(let error):
                throw error
            }
        }
        fatalError("requestAccessTokenResult não foi configurado para o mock.")
    }
    
    func updateAccessToken(_ newToken: String) {
        updateAccessTokenCalled = true
        receivedAccessToken = newToken
    }
}
