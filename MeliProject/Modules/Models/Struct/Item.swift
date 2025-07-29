//
//  Item.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

struct Item: Codable {
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
    let salePrice: Double? // Pode ser null
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
}
