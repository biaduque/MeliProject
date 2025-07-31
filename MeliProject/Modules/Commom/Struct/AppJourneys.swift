//
//  DecodeJourney.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

struct AppJourneys: Codable {
    let home: ImplementationType
    let detail: ImplementationType
    let buyProduct: ImplementationType

    private enum CodingKeys: String, CodingKey {
        case home
        case detail
        case buyProduct
    }
}
