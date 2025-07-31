//
//  Untitled.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//
import Foundation

// MARK: - Resposta da API de Busca (SearchResult)
/// **SearchResult**
/// Corresponde a: GET /sites/{SITE_ID}/search
/// Doc: https://developers.mercadolivre.com.br/pt_br/itens-e-buscas
struct SearchResult: Decodable {
    let siteID: String?
    let query: String?
    let paging: Paging // Informações de paginação
    var results: [Item] // Array de itens encontrados (criado como "var" para ser incrementado na paginacao)
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [Filter]?
    
    private enum CodingKeys: String, CodingKey {
        case query, paging, results, sort, filters
        case siteID = "site_id"
        case availableSorts = "available_sorts"
        case availableFilters = "available_filters"
    }
}


// MARK: - Paging (Detalhes da Paginação para SearchResults)
struct Paging: Codable {
    let total: Int
    let primaryResults: Int?
    let offset: Int
    let limit: Int
    
    private enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults = "primary_results"
    }
}

// MARK: - Installments (Informações de Parcelamento)
struct Installments: Codable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyID: String
    
    private enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

// MARK: - Sort (Opções de Ordenação)
struct Sort: Codable {
    let id: String?
    let name: String?
}

// MARK: - Filter (Filtros Aplicados/Disponíveis)
struct Filter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [FilterValue]?
}

// MARK: - FilterValue (Valores de um Filtro)
struct FilterValue: Codable {
    let id: String?
    let name: String?
    let pathFromRoot: [FilterValue]?
    let results: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, results
        case pathFromRoot = "path_from_root"
    }
}
