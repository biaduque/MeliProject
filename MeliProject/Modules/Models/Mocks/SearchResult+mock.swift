//
//  SearchResult+mock.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import Foundation

// MARK: - Extensão para Mocks de SearchResults e Item
/// Retorna um objeto `SearchResult` mock, simulando uma busca por "iPhone".
extension SearchResult {
    static func mockiPhoneSearchResults() -> SearchResult {
        return SearchResult(
            siteID: "MLB",
            query: "iphone",
            paging: Paging(total: 12345, primaryResults: 10000, offset: 0, limit: 50),
            results: [
                Item(
                    id: "MLB1234567890",
                    title: "Apple iPhone 13 (128 GB) – Estelar",
                    condition: "new",
                    thumbnailID: "876543-MLA51571477742_092022", // Exemplo de ID de thumbnail
                    catalogProductID: "MLB20625902",
                    listingTypeID: "GOLD_PRO",
                    permalink: "https://articulo.mercadolivre.com.br/MLB-1234567890-apple-iphone-13-128-gb-estelar-_JM",
                    buyingMode: "buy_it_now",
                    siteID: "MLB",
                    categoryID: "MLB1055",
                    domainID: "MLB-CELLPHONES",
                    warranty: "Garantia de fábrica: 1 ano",
                    currencyID: "BRL",
                    price: 3899.00,
                    originalPrice: 4299.00,
                    salePrice: nil,
                    availableQuantity: 500,
                    soldQuantity: 1200,
                    officialStoreID: 123,
                    tags: ["best_seller", "good_quality_picture"],
                    installments: Installments(quantity: 10, amount: 389.90, rate: 0, currencyID: "BRL"),
                    shipping: Shipping(freeShipping: true, mode: "me2", tags: ["self_service_in", "mandatory_free_shipping"], logisticType: "fulfillment", storePickUp: false),
                    stopTime: "2025-12-31T23:59:59.000Z",
                    seller: Seller(id: 123456789, permalink: "http://perfil.mercadolivre.com.br/TEST.SELLER", powerSellerStatus: "gold", carDealer: false, realEstateAgency: false, tags: []),
                    attributes: [
                        Attribute(id: "BRAND", name: "Marca", valueID: "8724", valueName: "Apple", valueStruct: nil, values: [AttributeValue(id: "8724", name: "Apple", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "MODEL", name: "Modelo", valueID: nil, valueName: "iPhone 13", valueStruct: nil, values: [AttributeValue(id: nil, name: "iPhone 13", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros")
                    ],
                    differentialPricing: DifferentialPricing(id: 12345678),
                    pictures: [
                        Picture(id: "876543-MLA51571477742_092022", url: "https://http2.mlstatic.com/D_876543-MLA51571477742_092022-O.jpg", secureURL: "https://http2.mlstatic.com/D_876543-MLA51571477742_092022-O.jpg", size: "500x500", maxSize: "1200x1200", quality: "80")
                    ],
                    acceptsMercadopago: true,
                    status: "active",
                    description: "O iPhone 13 oferece um sistema de câmera dupla avançado, tela Super Retina XDR mais brilhante e o chip A15 Bionic para um desempenho ultrarrápido. Bateria com grande duração e resistência à água.",
                    listingSource: "MLB",
                    variations: nil
                ),
                Item(
                    id: "MLB0987654321",
                    title: "Apple iPhone 14 Pro (256 GB) – Roxo-profundo",
                    condition: "new",
                    thumbnailID: "123456-MLA789012345_012023",
                    catalogProductID: "MLB20626001",
                    listingTypeID: "GOLD_PREMIUM",
                    permalink: "https://articulo.mercadolivre.com.br/MLB-0987654321-apple-iphone-14-pro-256-gb-roxo-profundo-_JM",
                    buyingMode: "buy_it_now",
                    siteID: "MLB",
                    categoryID: "MLB1055",
                    domainID: "MLB-CELLPHONES",
                    warranty: "Garantia de fábrica: 1 ano",
                    currencyID: "BRL",
                    price: 6199.00,
                    originalPrice: 6599.00,
                    salePrice: nil,
                    availableQuantity: 200,
                    soldQuantity: 800,
                    officialStoreID: 456,
                    tags: ["good_quality_picture"],
                    installments: Installments(quantity: 12, amount: 516.58, rate: 0, currencyID: "BRL"),
                    shipping: Shipping(freeShipping: true, mode: "me2", tags: ["self_service_in"], logisticType: "fulfillment", storePickUp: false),
                    stopTime: "2025-11-15T23:59:59.000Z",
                    seller: Seller(id: 987654321, permalink: "http://perfil.mercadolivre.com.br/OUTRO.SELLER", powerSellerStatus: "platinum", carDealer: false, realEstateAgency: false, tags: []),
                    attributes: [
                        Attribute(id: "BRAND", name: "Marca", valueID: "8724", valueName: "Apple", valueStruct: nil, values: [AttributeValue(id: "8724", name: "Apple", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "MODEL", name: "Modelo", valueID: nil, valueName: "iPhone 14 Pro", valueStruct: nil, values: [AttributeValue(id: nil, name: "iPhone 14 Pro", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros")
                    ],
                    differentialPricing: DifferentialPricing(id: 98765432),
                    pictures: [
                        Picture(id: "123456-MLA789012345_012023", url: "https://http2.mlstatic.com/D_123456-MLA789012345_012023-O.jpg", secureURL: "https://http2.mlstatic.com/D_123456-MLA789012345_012023-O.jpg", size: "600x600", maxSize: "1500x1500", quality: "85")
                    ],
                    acceptsMercadopago: true,
                    status: "active",
                    description: "Com a Dynamic Island e tela Sempre Ativa, o iPhone 14 Pro eleva a experiência do usuário. Câmera principal de 48 MP e o chip A16 Bionic proporcionam desempenho e qualidade fotográfica sem precedentes.",
                    listingSource: "MLB",
                    variations: [
                        Variation(id: 1, price: 6199.00, attributeCombinations: [
                            Attribute(id: "COLOR", name: "Cor", valueID: "2", valueName: "Roxo-profundo", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil)
                        ], availableQuantity: 100, soldQuantity: 200, pictureIDs: ["123456-MLA789012345_012023"])
                    ]
                )
            ],
            sort: Sort(id: "relevance", name: "Mais relevantes"),
            availableSorts: [
                Sort(id: "relevance", name: "Mais relevantes"),
                Sort(id: "price_asc", name: "Menor preço"),
                Sort(id: "price_desc", name: "Maior preço")
            ],
            filters: [],
            availableFilters: []
        )
    }
}
