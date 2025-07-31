//
//  ItemInfoTypeTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
@testable import MeliProject 

class ItemInfoTypeTests: XCTestCase {

    // MARK: - 'title'

    func test_title_forProduct() {
        let type = ItemInfoType.title
        XCTAssertEqual(type.title, "Produto")
    }

    func test_title_forPrice() {
        let type = ItemInfoType.price
        XCTAssertEqual(type.title, "Preço")
    }

    func test_title_forOriginalPrice() {
        let type = ItemInfoType.originalPrice
        XCTAssertEqual(type.title, "Preço Original")
    }
    
    func test_title_forCondition() {
        let type = ItemInfoType.condition
        XCTAssertEqual(type.title, "Condição")
    }
    
    func test_title_forAvailability() {
        let type = ItemInfoType.availability
        XCTAssertEqual(type.title, "Disponibilidade")
    }
    
    func test_title_forFreeShipping() {
        let type = ItemInfoType.freeShipping
        XCTAssertEqual(type.title, "Frete")
    }
    
    func test_title_forSellerInfo() {
        let type = ItemInfoType.sellerInfo
        XCTAssertEqual(type.title, "Informações do Vendedor")
    }
    
    func test_title_forAttributes() {
        let type = ItemInfoType.attributes
        XCTAssertEqual(type.title, "Características")
    }

    // MARK: - 'icon'

    func test_icon_forTitle() {
        let type = ItemInfoType.title
        XCTAssertEqual(type.icon, "tag.fill")
    }

    func test_icon_forPrice() {
        let type = ItemInfoType.price
        XCTAssertEqual(type.icon, "dollarsign.circle.fill")
    }

    func test_icon_forOriginalPrice() {
        let type = ItemInfoType.originalPrice
        XCTAssertEqual(type.icon, "dollarsign.circle")
    }
    
    func test_icon_forCondition() {
        let type = ItemInfoType.condition
        XCTAssertEqual(type.icon, "sparkles")
    }
    
    func test_icon_forAvailability() {
        let type = ItemInfoType.availability
        XCTAssertEqual(type.icon, "shippingbox.fill")
    }
    
    func test_icon_forFreeShipping() {
        let type = ItemInfoType.freeShipping
        XCTAssertEqual(type.icon, "truck.box.fill")
    }
    
    func test_icon_forSellerInfo() {
        let type = ItemInfoType.sellerInfo
        XCTAssertEqual(type.icon, "person.crop.circle.fill")
    }
    
    func test_icon_forAttributes() {
        let type = ItemInfoType.attributes
        XCTAssertEqual(type.icon, "checklist.checked")
    }

    // MARK: - Testes para a Função 'info(item:)'
    var mockItem: Item!

    override func setUp() {
        super.setUp()
        mockItem = ItemMock.mockiPhone13Detail()
        XCTAssertNotNil(mockItem, "Mock item should not be nil for tests.")
    }

    override func tearDown() {
        mockItem = nil
        super.tearDown()
    }

    func test_info_forTitleCase_returnsItemTitle() {
        let infoType = ItemInfoType.title
        let infoString = infoType.info(item: mockItem)
        XCTAssertEqual(infoString, mockItem.title)
    }

    func test_info_forPriceCase_returnsFormattedPrice() {
        let infoType = ItemInfoType.price
        let infoString = infoType.info(item: mockItem)
        let expectedPrice = "R$ 3.899,00"
        XCTAssertEqual(infoString, expectedPrice)
    }

    func test_info_forOriginalPrice() {
        let infoType = ItemInfoType.originalPrice
        let infoString = infoType.info(item: mockItem)
        let expectedOriginalPrice = "R$ 4.299,00"
        XCTAssertEqual(infoString, expectedOriginalPrice)
    }

    func test_info_forOriginalPriceCaseNotAvailable() {
        // Given
        var itemWithoutOriginalPrice = mockItem!
        itemWithoutOriginalPrice = Item(
            id: itemWithoutOriginalPrice.id,
            title: itemWithoutOriginalPrice.title,
            condition: itemWithoutOriginalPrice.condition,
            thumbnailID: itemWithoutOriginalPrice.thumbnailID,
            catalogProductID: itemWithoutOriginalPrice.catalogProductID,
            listingTypeID: itemWithoutOriginalPrice.listingTypeID,
            permalink: itemWithoutOriginalPrice.permalink,
            buyingMode: itemWithoutOriginalPrice.buyingMode,
            siteID: itemWithoutOriginalPrice.siteID,
            categoryID: itemWithoutOriginalPrice.categoryID,
            domainID: itemWithoutOriginalPrice.domainID,
            warranty: itemWithoutOriginalPrice.warranty,
            currencyID: itemWithoutOriginalPrice.currencyID,
            price: itemWithoutOriginalPrice.price,
            originalPrice: nil,
            salePrice: itemWithoutOriginalPrice.salePrice,
            availableQuantity: itemWithoutOriginalPrice.availableQuantity,
            soldQuantity: itemWithoutOriginalPrice.soldQuantity,
            officialStoreID: itemWithoutOriginalPrice.officialStoreID,
            tags: itemWithoutOriginalPrice.tags,
            installments: itemWithoutOriginalPrice.installments,
            shipping: itemWithoutOriginalPrice.shipping,
            stopTime: itemWithoutOriginalPrice.stopTime,
            seller: itemWithoutOriginalPrice.seller,
            attributes: itemWithoutOriginalPrice.attributes,
            differentialPricing: itemWithoutOriginalPrice.differentialPricing,
            pictures: itemWithoutOriginalPrice.pictures,
            acceptsMercadopago: itemWithoutOriginalPrice.acceptsMercadopago,
            status: itemWithoutOriginalPrice.status,
            description: itemWithoutOriginalPrice.description,
            listingSource: itemWithoutOriginalPrice.listingSource,
            variations: itemWithoutOriginalPrice.variations
        )
        
        let infoType = ItemInfoType.originalPrice
        let infoString = infoType.info(item: itemWithoutOriginalPrice)
        let expectedPrice = "3899" 
        XCTAssertEqual(infoString, expectedPrice)
    }


    func test_info_forNewCondition() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: "new", thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.condition
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Novo")
    }

    func test_info_forUsedCondition() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: "used", thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.condition
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Usado")
    }
    
    func test_info_forUnknownCondition() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: "refurbished", thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.condition
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Desconhecida")
    }

    func test_info_quantitWhenAvailable() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: 15, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.availability
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Disponível: 15 unidade(s)")
    }
    
    func test_info_forWhenNotAvailable() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: nil, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.availability
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Verificar disponibilidade")
    }

    func test_info_forFreeShippingCase_returnsFreeShipping_whenTrue() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: Shipping(freeShipping: true, mode: nil, tags: nil, logisticType: nil, storePickUp: nil), stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.freeShipping
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Frete Grátis!")
    }
    
    func test_info_forWhenFalse() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: Shipping(freeShipping: false, mode: nil, tags: nil, logisticType: nil, storePickUp: nil), stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.freeShipping
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Frete a calcular")
    }
    
    func test_info_forWhenShippingIsNil() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: nil, stopTime: item.stopTime, seller: item.seller, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.freeShipping
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Frete a calcular")
    }

    func test_info_forWhenPowerSeller() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: Seller(id: 999, permalink: nil, powerSellerStatus: "gold", carDealer: false, realEstateAgency: false, tags: []), attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.sellerInfo
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Vendedor ID: 999\nStatus: Gold")
    }
    
    func test_info_forWhenNoPowerSeller() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: Seller(id: 111, permalink: nil, powerSellerStatus: nil, carDealer: false, realEstateAgency: false, tags: []), attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.sellerInfo
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Vendedor ID: 111")
    }
    
    func test_info_WhenSellerIsNil() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: nil, attributes: item.attributes, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.sellerInfo
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Informações do vendedor não disponíveis")
    }

    func test_info_WhenAvailable() {
        let infoType = ItemInfoType.attributes
        let infoString = infoType.info(item: mockItem)
        let expectedAttributes = """
        Marca: Apple
        Modelo: iPhone 13
        Capacidade de armazenamento: 128 GB
        Memória RAM: 6 GB
        """
        XCTAssertEqual(infoString, expectedAttributes)
    }
    
    func test_info_forWhenNoRelevantAttributes() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: [], differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.attributes
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Não especificado")
    }
    
    func test_info_forWhenAttributesAreNil() {
        var item = mockItem!
        item = Item(id: item.id, title: item.title, condition: item.condition, thumbnailID: item.thumbnailID, catalogProductID: item.catalogProductID, listingTypeID: item.listingTypeID, permalink: item.permalink, buyingMode: item.buyingMode, siteID: item.siteID, categoryID: item.categoryID, domainID: item.domainID, warranty: item.warranty, currencyID: item.currencyID, price: item.price, originalPrice: item.originalPrice, salePrice: item.salePrice, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity, officialStoreID: item.officialStoreID, tags: item.tags, installments: item.installments, shipping: item.shipping, stopTime: item.stopTime, seller: item.seller, attributes: nil, differentialPricing: item.differentialPricing, pictures: item.pictures, acceptsMercadopago: item.acceptsMercadopago, status: item.status, description: item.description, listingSource: item.listingSource, variations: item.variations)
        let infoType = ItemInfoType.attributes
        let infoString = infoType.info(item: item)
        XCTAssertEqual(infoString, "Não especificado")
    }

    // MARK: - Testes para a Função 'rowHeight()'

    func test_rowHeight_forAttributesCase_returns150() {
        let infoType = ItemInfoType.attributes
        XCTAssertEqual(infoType.rowHeight(), 150)
    }

    func test_rowHeight_forDefaultCases_returns65() {
        let infoType1 = ItemInfoType.title
        let infoType2 = ItemInfoType.price
       
        XCTAssertEqual(infoType1.rowHeight(), 65)
        XCTAssertEqual(infoType2.rowHeight(), 65)
        ItemInfoType.allCases.forEach { type in
            if type != .attributes {
                XCTAssertEqual(type.rowHeight(), 65, "rowHeight for \(type.title) should be 65")
            }
        }
    }
}
