//
//  Error.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//


import Foundation

enum MeliAPIError: Error, LocalizedError {
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
