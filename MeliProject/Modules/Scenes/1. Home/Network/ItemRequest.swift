//
//  ItemRequest.swift
//  MeliProject
//
//  Created by Beatriz Duque on 28/07/25.
//

import UIKit

class ItemRequest {
    static var method: HttpMethod = .GET
    static let page: String = "1"
    
    static func configuteRequest(itemSearched: String) -> URLRequest? {
        let query = itemSearched
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(MeliAPIManager.baseURL)/sites/MLB/search?q=\(encodedQuery)&offset=\(page)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.setup()
        request.setValue("Bearer \(TokenManager.value)", forHTTPHeaderField: "Authorization")
        return request
    }
}
