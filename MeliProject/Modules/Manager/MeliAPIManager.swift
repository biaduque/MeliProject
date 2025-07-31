//
//  MeliAPIManager.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit
import Foundation

// MARK: - Protocolo MeliAPIManager
protocol MeliAPIManagerProtocol {
    func requestAccessToken(code: String, clientID: String, clientSecret: String, redirectURI: String) async throws -> TokenResponse
    func updateAccessToken(_ newToken: String)
}

public class MeliAPIManager: MeliAPIManagerProtocol {
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
    
    static func loadFileContent(from fileName: String, withExtension fileExtension: String) -> String? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Erro (loadFileContent): Arquivo '\(fileName).\(fileExtension)' não encontrado no bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            guard let contentString = String(data: data, encoding: .utf8) else {
                print("Erro (loadFileContent): Não foi possível converter o conteúdo do arquivo '\(fileName).\(fileExtension)' para String (UTF-8).")
                return nil
            }
            
            return contentString
        } catch {
            print("Erro (loadFileContent): Falha ao ler o conteúdo do arquivo '\(fileName).\(fileExtension)': \(error.localizedDescription)")
            return nil
        }
    }
    
    static func decodeJSON<T: Decodable>(from jsonString: String, as type: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Erro (decodeJSON): Não foi possível converter a string JSON para Data.")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            let decodedObject = try decoder.decode(type, from: jsonData)
            print("Sucesso (decodeJSON): Objeto do tipo \(type) decodificado.")
            return decodedObject
        } catch {
            print("Erro (decodeJSON) ao decodificar para o tipo \(type): \(error.localizedDescription)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    print("  - Data Corrupted: \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("  - Key '\(key.stringValue)' not found: \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    print("  - Value of type '\(type)' not found: \(context.debugDescription)")
                case .typeMismatch(let type, let context):
                    print("  - Type mismatch for type '\(type)': \(context.debugDescription)")
                @unknown default:
                    print("  - Unknown decoding error: \(error)")
                }
            }
            return nil
        }
    }
}
