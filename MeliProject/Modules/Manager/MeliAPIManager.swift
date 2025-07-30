//
//  MeliAPIManager.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit
import Foundation

public class MeliAPIManager {
    public static let baseURL = "https://api.mercadolibre.com"
    private var accessToken: String? // Renovar

    init(accessToken: String?) {
        self.accessToken = accessToken
    }

    func updateAccessToken(_ newToken: String) {
        self.accessToken = newToken
    }

    func requestAccessToken(code: String, clientID: String, clientSecret: String, redirectURI: String) async throws -> TokenResponse {
        guard let url = URL(string: "\(MeliAPIManager.baseURL)/oauth/token") else {
            throw MeliAPIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parameters = "grant_type=authorization_code&client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectURI)"
        request.httpBody = parameters.data(using: .utf8)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorMessage: String?
                if let errorData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = errorData["message"] as? String {
                    errorMessage = message
                } else {
                    errorMessage = nil
                }
                throw MeliAPIError.apiError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0, message: errorMessage)
            }

            let decoder = JSONDecoder()
            let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
            return tokenResponse
        } catch let urlError as URLError {
            throw MeliAPIError.networkError(urlError)
        } catch let decodingError as DecodingError {
            throw MeliAPIError.decodingError(decodingError)
        } catch {
            throw error
        }
    }
}
