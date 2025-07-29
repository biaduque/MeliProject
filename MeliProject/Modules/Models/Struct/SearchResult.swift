//
//  Untitled.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import Foundation

// MARK: - Top-level SearchResults
struct SearchResult: Codable {
    let siteID: String?
    let query: String?
    let paging: Paging
    var results: [Item]
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [Filter]?
}

// MARK: - Paging

struct Paging: Codable {
    let total: Int
    let primaryResults: Int?
    let offset: Int
    let limit: Int
}

// MARK: - Item


// MARK: - Installments

struct Installments: Codable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyID: String
}

// MARK: - Shipping

struct Shipping: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool? // Adicionado, pode estar presente em algumas respostas
}

// MARK: - Seller

struct Seller: Codable {
    let id: Int
    let permalink: String?
    let powerSellerStatus: String?
    let carDealer: Bool?
    let realEstateAgency: Bool?
    let tags: [String]?
}

// MARK: - Attribute

struct Attribute: Codable {
    let id: String?
    let name: String?
    let valueID: String?
    let valueName: String?
    let valueStruct: AttributeValueStruct? // Pode ser null
    let values: [AttributeValue]?
    let attributeGroupID: String?
    let attributeGroupName: String?
}

// MARK: - AttributeValue

struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let structValue: AttributeValueStruct? // Usado para evitar conflito com 'struct' keyword
    let source: Int? // Pode aparecer em alguns atributos

    private enum CodingKeys: String, CodingKey {
        case id, name
        case structValue = "struct" // Mapeia "struct" do JSON para "structValue" em Swift
        case source
    }
}

// MARK: - AttributeValueStruct (para value_struct e struct dentro de values)

struct AttributeValueStruct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - DifferentialPricing

struct DifferentialPricing: Codable {
    let id: Int?
}

// MARK: - Sort

struct Sort: Codable {
    let id: String?
    let name: String?
}

// MARK: - Filter

struct Filter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [FilterValue]?
}

// MARK: - FilterValue

struct FilterValue: Codable {
    let id: String?
    let name: String?
    let pathFromRoot: [FilterValue]? // Para filtros hierárquicos
    let results: Int?
}
