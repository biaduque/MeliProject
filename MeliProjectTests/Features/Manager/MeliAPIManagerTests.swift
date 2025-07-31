//
//  MeliAPIManagerTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
@testable import MeliProject

final class MeliAPIManagerTests: XCTestCase {
    func testUpdateAccessToken() {
        let manager = MeliAPIManager(accessToken: "token_inicial")
        manager.updateAccessToken("novo_token")
        XCTAssertNoThrow(manager.updateAccessToken("outro_token"))
    }

    func testLoadFileContentSuccess() {
        let content = MeliAPIManager.loadFileContent(from: "app_journeys_config", withExtension: "json")
        XCTAssertNotNil(content)
    }

    func testLoadFileContentArquivoNaoEncontrado() {
        let content = MeliAPIManager.loadFileContent(from: "ArquivoInexistente", withExtension: "txt")
        XCTAssertNil(content)
    }

    func testDecodeJSONSucesso() {
        let jsonString = MeliAPIManager.loadFileContent(from: "token_mock_test", withExtension: "json")!
        let result = MeliAPIManager.decodeJSON(from: jsonString, as: TokenResponse.self)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.accessToken, "abc123mocktoken")
    }

    func testDecodeJSONInvalido() {
        let jsonString = #"{"access_token":123}"#
        let result = MeliAPIManager.decodeJSON(from: jsonString, as: TokenResponse.self)
        XCTAssertNil(result)
    }

    func testDecodeJSONStringInvalida() {
        let jsonString = String(data: Data([0xFF, 0xD8, 0xFF]), encoding: .utf16) ?? ""
        let result = MeliAPIManager.decodeJSON(from: jsonString, as: TokenResponse.self)
        XCTAssertNil(result)
    }
}
