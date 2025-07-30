//
//  Item.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

// MARK: - Modelo de Item
/// **Item**:
/// Corresponde a: GET /items/{ITEM_ID} (diretamente)
/// E também é um elemento do array 'results' em SearchResults
/// Usado tanto na Busca quanto nos Detalhes do Item
/// Doc:  https://developers.mercadolivre.com.br/pt_br/publicacao-de-produtos
struct Item: Codable {
    let id: String
    let title: String
    let condition: String? // "new", "used"
    let thumbnailID: String? // ID da imagem em miniatura
    let catalogProductID: String?
    let listingTypeID: String?
    let permalink: String? // URL do item no Mercado Livre
    let buyingMode: String?
    let siteID: String? // "MLB"
    let categoryID: String?
    let domainID: String?
    let warranty: String?
    let currencyID: String? //"BRL"
    let price: Double
    let originalPrice: Double? // Preço antes de um desconto, se houver
    let salePrice: Double? // Preço de venda em promoção
    let availableQuantity: Int?
    let soldQuantity: Int?
    let officialStoreID: Int? // ID da loja oficial, se aplicável
    let tags: [String]?
    let installments: Installments? // Informações de parcelamento
    let shipping: Shipping? // Informações de frete
    let stopTime: String?
    let seller: Seller?
    let attributes: [Attribute]? // Atributos do produto
    let differentialPricing: DifferentialPricing?
    
    // Para a API de detalhes
    let pictures: [Picture]? // Array de imagens do produto
    let acceptsMercadopago: Bool?
    let status: String? // Ex: "active"
    let description: String? // Pode retornar string ou Plain text, necessário add verificação.
    let listingSource: String?
    let variations: [Variation]? // Variações do produto
}

// MARK: - Shipping (Informações de Frete)
struct Shipping: Codable {
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?
}

// MARK: - Seller (Informações do Vendedor)
struct Seller: Codable {
    let id: Int
    let permalink: String?
    let powerSellerStatus: String?
    let carDealer: Bool?
    let realEstateAgency: Bool?
    let tags: [String]?
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

    // Para evitar conflito com a palavra-chave 'struct' em Swift
    private enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case valueStruct = "value_struct"
        case values
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
    }
}

// MARK: - AttributeValue (Valor de um Atributo)
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let structValue: AttributeValueStruct? // Mapeia "struct" do JSON para "structValue"
    let source: Int?

    private enum CodingKeys: String, CodingKey {
        case id, name
        case structValue = "struct"
        case source
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
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

// MARK: - Variation (Variações do Produto - Principalmente para Detalhes do Item)
struct Variation: Codable {
    let id: Int
    let price: Double?
    let attributeCombinations: [Attribute]? // Combinação de atributos
    let availableQuantity: Int?
    let soldQuantity: Int?
    let pictureIDs: [String]? // IDs das imagens específicas para esta variação

    private enum CodingKeys: String, CodingKey {
        case id, price
        case attributeCombinations = "attribute_combinations"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case pictureIDs = "picture_ids"
    }
}
