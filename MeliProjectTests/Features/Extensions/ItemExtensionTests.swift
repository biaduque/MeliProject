//
//  ItemExtensionTests.swift
//  MeliProject
//
//  Created by Beatriz Duque on 31/07/25.
//

import XCTest
@testable import MeliProject

class ItemExtensionTests: XCTestCase {

    // MARK: - Tests for thumbnailUrl()

    func test_returnsCorrectURL() {
        // Given
        let validThumbnailID = "736168-MLA47781742030_102021"
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: validThumbnailID,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let urlString = item.thumbnailUrl()
        
        // Then
        let expectedURLString = "https://http2.mlstatic.com/D_NQ_NP_2X_736168-MLA47781742030_102021-T.jpg"
        XCTAssertEqual(urlString, expectedURLString)
    }

    func test_returnsEmptyString() {
        // Given
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: nil,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let urlString = item.thumbnailUrl()
        
        // Then
        XCTAssertEqual(urlString, "")
    }
    
    func test_thumbnailReturnsEmptyString() {
        // Given
        let invalidThumbnailID = "INVALID_FORMAT"
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: invalidThumbnailID,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: nil, acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let urlString = item.thumbnailUrl()
        
        // Then
        XCTAssertEqual(urlString, "")
    }

    // MARK: - Tests for mainPictureUrl()

    func test_mainPicReturnsCorrectURL() {
        // Given
        let validPictureURLString = "https://http2.mlstatic.com/D_876543-MLA51571477742_092022-O.jpg"
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: nil,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: [Picture(id: "someId", url: validPictureURLString, secureURL: nil, size: nil, maxSize: nil, quality: nil)],
            acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let url = item.mainPictureUrl()
        
        // Then
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, validPictureURLString)
    }

    func test_returnsNil() {
        // Given
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: nil,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: [], // Array vazio
            acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let url = item.mainPictureUrl()
        
        // Then
        XCTAssertNil(url)
    }

    func test_mainPictureUrlArray_returnsNil() {
        // Given
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: nil,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: nil, // Array nil
            acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let url = item.mainPictureUrl()
        
        // Then
        XCTAssertNil(url)
    }
    
    func test_mainPictureUrlString_returnsNil() {
        // Given
        let invalidPictureURLString = "not a valid url"
        let item = Item(
            id: "anyId", title: "Any Title", condition: nil, thumbnailID: nil,
            catalogProductID: nil, listingTypeID: nil, permalink: nil, buyingMode: nil,
            siteID: nil, categoryID: nil, domainID: nil, warranty: nil, currencyID: nil,
            price: 0, originalPrice: nil, salePrice: nil, availableQuantity: nil,
            soldQuantity: nil, officialStoreID: nil, tags: nil, installments: nil,
            shipping: nil, stopTime: nil, seller: nil, attributes: nil, differentialPricing: nil,
            pictures: [Picture(id: "someId", url: invalidPictureURLString, secureURL: nil, size: nil, maxSize: nil, quality: nil)],
            acceptsMercadopago: nil, status: nil, description: nil, listingSource: nil, variations: nil
        )
        
        // When
        let url = item.mainPictureUrl()
        
        // Then
        XCTAssertEqual(url, URL(string:"not%20a%20valid%20url"))
    }
}
