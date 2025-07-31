//
//  ItemMock.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

@testable import MeliProject

struct ItemMock {
    static func mockiPhone13Detail() -> Item {
            return Item(
                id: "MLB1234567890",
                title: "Apple iPhone 13 (128 GB) – Estelar",
                condition: "new",
                thumbnailID: "736168-MLA47781742030_102021",
                catalogProductID: "MLB20625902",
                listingTypeID: "GOLD_PRO",
                permalink: "https://www.mercadolivre.com.br/iphone-13-dual-sim-256-gb-estelar-novo-com-caixa-aberta/p/MLB2016198734#polycard_client=search-nordic&searchVariation=MLB2016198734&wid=MLB5507112276&position=4&search_layout=stack&type=product&tracking_id=0a3dc8d2-04ee-4f90-89fe-aebf915c94d3&sid=search",
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
                    Attribute(id: "MODEL", name: "Modelo", valueID: nil, valueName: "iPhone 13", valueStruct: nil, values: [AttributeValue(id: nil, name: "iPhone 13", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                    Attribute(id: "CAPACITY", name: "Capacidade de armazenamento", valueID: "128GB", valueName: "128 GB", valueStruct: nil, values: nil, attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                    Attribute(id: "RAM", name: "Memória RAM", valueID: "6GB", valueName: "6 GB", valueStruct: nil, values: nil, attributeGroupID: "OTHERS", attributeGroupName: "Outros")
                ],
                differentialPricing: DifferentialPricing(id: 12345678),
                pictures: [
                    Picture(id: "736168-MLA47781742030_102021", url: "https://http2.mlstatic.com/D_NQ_NP_2X_736168-MLA47781742030_102021-T.jpg", secureURL: "https://http2.mlstatic.com/D_876543-MLA51571477742_092022-O.jpg", size: "500x500", maxSize: "1200x1200", quality: "80"),
                    Picture(id: "736168-MLA47781742030_102021", url: "https://http2.mlstatic.com/D_987654-MLA51571477742_092022-O.jpg", secureURL: "https://http2.mlstatic.com/D_987654-MLA51571477742_092022-O.jpg", size: "500x500", maxSize: "1200x1200", quality: "80")
                ],
                acceptsMercadopago: true,
                status: "active",
                description: "O iPhone 13 oferece um sistema de câmera dupla avançado, tela Super Retina XDR mais brilhante e o chip A15 Bionic para um desempenho ultrarrápido. Bateria com grande duração e resistência à água. Câmeras de 12MP, modo cinema, gravação de vídeo 4K HDR. Ideal para quem busca alta performance e qualidade em um smartphone. Aparelho novo, lacrado e com garantia do fabricante.",
                listingSource: "MLB",
                variations: [
                    Variation(id: 1, price: 3899.00, attributeCombinations: [
                        Attribute(id: "COLOR", name: "Cor", valueID: "1", valueName: "Estelar", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil),
                        Attribute(id: "STORAGE_CAPACITY", name: "Capacidade", valueID: "128GB", valueName: "128 GB", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil)
                    ], availableQuantity: 200, soldQuantity: 500, pictureIDs: ["876543-MLA51571477742_092022"])
                ]
            )
        }
        
        /// Mock que retorna o array de itens diretamente, para simular uma busca por id do produto
        static func mockiPhoneDetails() -> [Item] {
            return [
                Item(
                    id: "MLB1234567890",
                    title: "Apple iPhone 13 (128 GB) – Estelar",
                    condition: "new",
                    thumbnailID: "736168-MLA47781742030_102021",
                    catalogProductID: "MLB20625902",
                    listingTypeID: "GOLD_PRO",
                    permalink: "https://www.mercadolivre.com.br/iphone-13-dual-sim-256-gb-estelar-novo-com-caixa-aberta/p/MLB2016198734#polycard_client=search-nordic&searchVariation=MLB2016198734&wid=MLB5507112276&position=4&search_layout=stack&type=product&tracking_id=0a3dc8d2-04ee-4f90-89fe-aebf915c94d3&sid=search",
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
                    tags: ["best_seller", "good_quality_picture", "good_seller"],
                    installments: Installments(quantity: 10, amount: 389.90, rate: 0, currencyID: "BRL"),
                    shipping: Shipping(freeShipping: true, mode: "me2", tags: ["self_service_in", "mandatory_free_shipping"], logisticType: "fulfillment", storePickUp: false),
                    stopTime: "2025-12-31T23:59:59.000Z",
                    seller: Seller(id: 123456789, permalink: "http://perfil.mercadolivre.com.br/TEST.SELLER", powerSellerStatus: "gold", carDealer: false, realEstateAgency: false, tags: []),
                    attributes: [
                        Attribute(id: "BRAND", name: "Marca", valueID: "8724", valueName: "Apple", valueStruct: nil, values: [AttributeValue(id: "8724", name: "Apple", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "MODEL", name: "Modelo", valueID: nil, valueName: "iPhone 13", valueStruct: nil, values: [AttributeValue(id: nil, name: "iPhone 13", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "CAPACITY", name: "Capacidade de armazenamento", valueID: "20000000", valueName: "128 GB", valueStruct: nil, values: [AttributeValue(id: "20000000", name: "128 GB", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "RAM", name: "Memória RAM", valueID: nil, valueName: "4 GB", valueStruct: nil, values: [AttributeValue(id: nil, name: "4 GB", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "COLOR", name: "Cor principal", valueID: "777777", valueName: "Estelar", valueStruct: nil, values: [AttributeValue(id: "777777", name: "Estelar", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros")
                    ],
                    differentialPricing: DifferentialPricing(id: 12345678),
                    pictures: [
                        Picture(id: "736168-MLA47781742030_102021", url: "https://http2.mlstatic.com/D_NQ_NP_2X_736168-MLA47781742030_102021-T.jpg", secureURL: "https://http2.mlstatic.com/D_876543-MLA51571477742_092022-O.jpg", size: "500x500", maxSize: "1200x1200", quality: "80"),
                        Picture(id: "736168-MLA47781742030_102021", url: "https://http2.mlstatic.com/D_987654-MLA51571477742_092022-O.jpg", secureURL: "https://http2.mlstatic.com/D_987654-MLA51571477742_092022-O.jpg", size: "500x500", maxSize: "1200x1200", quality: "80")
                    ],
                    acceptsMercadopago: true,
                    status: "active",
                    description: "O iPhone 13 oferece um sistema de câmera dupla avançado, tela Super Retina XDR mais brilhante e o chip A15 Bionic para um desempenho ultrarrápido. Bateria com grande duração e resistência à água e poeira. Câmeras de 12MP com Modo Cinema, Estilos Fotográficos e gravação de vídeo 4K HDR. Ideal para quem busca alta performance e qualidade em um smartphone. Aparelho novo, lacrado e com garantia do fabricante. Conteúdo da embalagem: iPhone, Cabo de USB-C para Lightning e Documentação.",
                    listingSource: "MLB",
                    variations: [
                        Variation(id: 1001, price: 3899.00, attributeCombinations: [
                            Attribute(id: "COLOR", name: "Cor", valueID: "777777", valueName: "Estelar", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil),
                            Attribute(id: "STORAGE_CAPACITY", name: "Capacidade", valueID: "20000000", valueName: "128 GB", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil)
                        ], availableQuantity: 300, soldQuantity: 700, pictureIDs: ["876543-MLA51571477742_092022"])
                    ]
                ),
                
                Item(
                    id: "MLB0987654321",
                    title: "Apple iPhone 14 Pro (256 GB) – Gold Premium",
                    condition: "new",
                    thumbnailID: "626715-MLU69495173557_052023",
                    catalogProductID: "MLB20626001",
                    listingTypeID: "GOLD_PREMIUM",
                    permalink: "https://www.mercadolivre.com.br/apple-iphone-14-pro-128-gb-dourado-excelente-recondicionado/p/MLB2000138020#polycard_client=search-nordic&searchVariation=MLB2000138020&wid=MLB4094028187&position=19&search_layout=stack&type=product&tracking_id=35fd4768-9ad6-4efc-98a7-79b81e92967b&sid=search",
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
                    tags: ["good_quality_picture", "official_store"],
                    installments: Installments(quantity: 12, amount: 516.58, rate: 0, currencyID: "BRL"),
                    shipping: Shipping(freeShipping: true, mode: "me2", tags: ["self_service_in"], logisticType: "fulfillment", storePickUp: false),
                    stopTime: "2025-11-15T23:59:59.000Z",
                    seller: Seller(id: 987654321, permalink: "http://perfil.mercadolivre.com.br/OUTRO.SELLER", powerSellerStatus: "platinum", carDealer: false, realEstateAgency: false, tags: []),
                    attributes: [
                        Attribute(id: "BRAND", name: "Marca", valueID: "8724", valueName: "Apple", valueStruct: nil, values: [AttributeValue(id: "8724", name: "Apple", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "MODEL", name: "Modelo", valueID: nil, valueName: "iPhone 14 Pro", valueStruct: nil, values: [AttributeValue(id: nil, name: "iPhone 14 Pro", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "CAPACITY", name: "Capacidade de armazenamento", valueID: "20000001", valueName: "256 GB", valueStruct: nil, values: [AttributeValue(id: "20000001", name: "256 GB", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "RAM", name: "Memória RAM", valueID: nil, valueName: "6 GB", valueStruct: nil, values: [AttributeValue(id: nil, name: "6 GB", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros"),
                        Attribute(id: "COLOR", name: "Cor principal", valueID: "888888", valueName: "Roxo-profundo", valueStruct: nil, values: [AttributeValue(id: "888888", name: "Roxo-profundo", structValue: nil, source: nil)], attributeGroupID: "OTHERS", attributeGroupName: "Outros")
                    ],
                    differentialPricing: DifferentialPricing(id: 98765432),
                    pictures: [
                        Picture(id: "626715-MLU69495173557_052023", url: "https://http2.mlstatic.com/D_NQ_NP_2X_626715-MLU69495173557_052023-T.jpg", secureURL: "https://http2.mlstatic.com/D_123456-MLA789012345_012023-O.jpg", size: "600x600", maxSize: "1500x1500", quality: "85"),
                        Picture(id: "626715-MLU69495173557_052023", url: "https://http2.mlstatic.com/D_789012-MLA789012345_012023-O.jpg", secureURL: "https://http2.mlstatic.com/D_789012-MLA789012345_012023-O.jpg", size: "600x600", maxSize: "1500x1500", quality: "85")
                    ],
                    acceptsMercadopago: true,
                    status: "active",
                    description: "Com a Dynamic Island e tela Sempre Ativa, o iPhone 14 Pro eleva a experiência do usuário a um novo patamar. Apresenta uma câmera principal de 48 MP para fotos incrivelmente detalhadas e o poderoso chip A16 Bionic, que proporciona desempenho ultrarrápido. Design elegante e robusto, com Ceramic Shield. Aparelho novo, lacrado e com garantia do fabricante.",
                    listingSource: "MLB",
                    variations: [
                        Variation(id: 2001, price: 6199.00, attributeCombinations: [
                            Attribute(id: "COLOR", name: "Cor", valueID: "888888", valueName: "Roxo-profundo", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil),
                            Attribute(id: "STORAGE_CAPACITY", name: "Capacidade", valueID: "20000001", valueName: "256 GB", valueStruct: nil, values: nil, attributeGroupID: nil, attributeGroupName: nil)
                        ], availableQuantity: 150, soldQuantity: 300, pictureIDs: ["123456-MLA789012345_012023"])
                    ]
                )
                
            ]
        }
}
