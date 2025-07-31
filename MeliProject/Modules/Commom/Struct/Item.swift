//
//  Item.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

// MARK: - Modelo de Item
/// **Item**:
/// Corresponde a: GET /items/{ITEM_ID} 
/// E também é um elemento do array 'results' em SearchResults
/// Usado tanto na Busca quanto nos Detalhes do Item
/// Doc:  https://developers.mercadolivre.com.br/pt_br/publicacao-de-produtos
import Foundation

struct Item: Decodable {
    let id: String
    let title: String
    let condition: String?
    let thumbnailID: String?
    let catalogProductID: String?
    let listingTypeID: String?
    let permalink: String?
    let buyingMode: String?
    let siteID: String?
    let categoryID: String?
    let domainID: String?
    let warranty: String?
    let currencyID: String?
    let price: Double
    let originalPrice: Double?
    let salePrice: Double?
    let availableQuantity: Int?
    let soldQuantity: Int?
    let officialStoreID: Int?
    let tags: [String]?
    let installments: Installments?
    let shipping: Shipping?
    let stopTime: String?
    let seller: Seller?
    let attributes: [Attribute]?
    let differentialPricing: DifferentialPricing?
    
    let pictures: [Picture]?
    let acceptsMercadopago: Bool?
    let status: String?
    let description: String?
    let listingSource: String?
    let variations: [Variation]?

    private enum CodingKeys: String, CodingKey {
        case id, title, condition, permalink, price, tags, installments, shipping, status, description, variations, warranty
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case currencyID = "currency_id"
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case officialStoreID = "official_store_id"
        case stopTime = "stop_time"
        case seller, attributes
        case differentialPricing = "differential_pricing"
        case pictures
        case acceptsMercadopago = "accepts_mercadopago"
        case listingSource = "listing_source"
    }
}

// MARK: - Shipping (Informações de Frete)
struct Shipping: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?

    private enum CodingKeys: String, CodingKey {
        case mode, tags
        case freeShipping = "free_shipping"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}

// MARK: - Seller (Informações do Vendedor)
struct Seller: Codable {
    let id: Int
    let permalink: String?
    let powerSellerStatus: String?
    let carDealer: Bool?
    let realEstateAgency: Bool?
    let tags: [String]?

    private enum CodingKeys: String, CodingKey {
        case id, tags, permalink
        case powerSellerStatus = "power_seller_status"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
    }
}

// MARK: - Attribute (Atributos do Item)
struct Attribute: Codable {
    let id: String?
    let name: String?
    let valueID: String?
    let valueName: String?
    let valueStruct: AttributeValueStruct?
    let values: [AttributeValue]?
    let attributeGroupID: String?
    let attributeGroupName: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, values
        case valueID = "value_id"
        case valueName = "value_name"
        case valueStruct = "value_struct"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
    }
}

// MARK: - AttributeValue (Valor de um Atributo)
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let structValue: AttributeValueStruct?
    let source: Int?

    private enum CodingKeys: String, CodingKey {
        case id, name, source
        case structValue = "struct"
    }
}

// MARK: - AttributeValueStruct (Estrutura de Valor para Atributos numéricos)
struct AttributeValueStruct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - DifferentialPricing (Informações de Preço Diferencial)
struct DifferentialPricing: Codable {
    let id: Int?

    private enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - Picture (Imagens do Produto - Principalmente para Detalhes do Item)
struct Picture: Codable {
    let id: String
    let url: String
    let secureURL: String?
    let size: String?
    let maxSize: String?
    let quality: String?

    private enum CodingKeys: String, CodingKey {
        case id, url, size, quality
        case secureURL = "secure_url"
        case maxSize = "max_size"
    }
}

// MARK: - Variation (Variações do Produto - Principalmente para Detalhes do Item)
struct Variation: Codable {
    let id: Int
    let price: Double?
    let attributeCombinations: [Attribute]?
    let availableQuantity: Int?
    let soldQuantity: Int?
    let pictureIDs: [String]?

    private enum CodingKeys: String, CodingKey {
        case id, price
        case attributeCombinations = "attribute_combinations"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case pictureIDs = "picture_ids"
    }
}
