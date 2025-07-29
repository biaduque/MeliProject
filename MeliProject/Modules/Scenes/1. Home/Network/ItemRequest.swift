//
//  ItemRequest.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

class ItemRequest {
    static var method: HttpMethod = .GET
    static let baseURL = "https://api.mercadolibre.com"
    static let page: String = "1"
    
    static func configuteRequest(itemSearched: String) -> URLRequest? {
        let query = "iphone"
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/sites/MLB/search?q=\(encodedQuery)&offset=\(page)") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.setup()
        request.setValue("Bearer \(TokenManager.value)", forHTTPHeaderField: "Authorization")
        return request
    }
}

import Foundation

enum MercadoLivreAPIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case apiError(statusCode: Int, message: String?)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "A URL da requisição é inválida."
        case .invalidResponse:
            return "Resposta inválida do servidor."
        case .decodingError(let error):
            return "Erro ao decodificar dados: \(error.localizedDescription)"
        case .networkError(let error):
            return "Erro de rede: \(error.localizedDescription)"
        case .apiError(let statusCode, let message):
            return "Erro da API do Mercado Livre: Código \(statusCode)\(message.map { ", Mensagem: \($0)" } ?? "")."
        }
    }
}

class MercadoLivreAPIManager {
    private let baseURL = "https://api.mercadolivre.com"
    private var accessToken: String? // Você precisará gerenciar a obtenção e renovação deste token

    init(accessToken: String?) {
        self.accessToken = accessToken
    }

    // Função para atualizar o token de acesso (se ele expirar, por exemplo)
    func updateAccessToken(_ newToken: String) {
        self.accessToken = newToken
    }


    // Exemplo de requisição POST para obter um access_token (geralmente feito no backend)
    // Se precisar simular ou testar diretamente do app, com MUITO CUIDADO com client_secret!
    func requestAccessToken(code: String, clientID: String, clientSecret: String, redirectURI: String) async throws -> TokenResponse {
        guard let url = URL(string: "\(baseURL)/oauth/token") else {
            throw MercadoLivreAPIError.invalidURL
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
                throw MercadoLivreAPIError.apiError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0, message: errorMessage)
            }

            let decoder = JSONDecoder()
            let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
            return tokenResponse
        } catch let urlError as URLError {
            throw MercadoLivreAPIError.networkError(urlError)
        } catch let decodingError as DecodingError {
            throw MercadoLivreAPIError.decodingError(decodingError)
        } catch {
            throw error
        }
    }
}
