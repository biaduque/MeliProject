//
//  HttpMethods.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

enum HttpMethod: String {
    case GET
    case POST
    
    func setup() -> String {
        switch self {
        case .GET:
            "GET"
        case .POST:
            "POST"
        }
    }
}
