//
//  MeliAPIErrorTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//


import XCTest
@testable import MeliProject

class MeliAPIErrorTests: XCTestCase {

    func test_invalidURL_errorDescription() {
        // Given
        let error = MeliAPIError.invalidURL
        
        // When
        let description = error.errorDescription
        
        // Then
        XCTAssertEqual(description, "A URL da requisição é inválida.")
    }
    
    func test_invalidResponse_errorDescription() {
        // Given
        let error = MeliAPIError.invalidResponse
        
        // When
        let description = error.errorDescription
        
        // Then
        XCTAssertEqual(description, "Resposta inválida do servidor.")
    }
    
    func test_decodingError_errorDescription() {
        // Given
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Dados corrompidos."])
        let decodingError = MeliAPIError.decodingError(underlyingError)
        
        // When
        let description = decodingError.errorDescription
        
        // Then
        XCTAssertEqual(description, "Erro ao decodificar dados: Dados corrompidos.")
    }
    
    func test_networkError_errorDescription() {
        // Given
        let underlyingError = URLError(.notConnectedToInternet)
        let networkError = MeliAPIError.networkError(underlyingError)
        
        // When
        let description = networkError.errorDescription
        
        // Then
        XCTAssertEqual(description, "Erro de rede: The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")
    }
    
    func test_apiError_withoutMessage_errorDescription() {
        // Given
        let statusCode = 404
        let apiError = MeliAPIError.apiError(statusCode: statusCode, message: nil)
        
        // When
        let description = apiError.errorDescription
        
        // Then
        XCTAssertEqual(description, "Erro da API do Mercado Livre: Código 404.")
    }
    
    func test_apiError_withMessage_errorDescription() {
        // Given
        let statusCode = 500
        let message = "Internal Server Error"
        let apiError = MeliAPIError.apiError(statusCode: statusCode, message: message)
        
        // When
        let description = apiError.errorDescription
        
        // Then
        XCTAssertEqual(description, "Erro da API do Mercado Livre: Código 500, Mensagem: Internal Server Error.")
    }
}
