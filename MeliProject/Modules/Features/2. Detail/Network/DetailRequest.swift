//
//  Untitled.swift
//  MeliProject
//
//  Created by Beatriz Duque on 30/07/25.
//

import UIKit

class DetailRequestBuilder {
    static var method: HttpMethod = .GET
    
    static func bindUrl(id: String) -> URLRequest? {
        guard let encodedQuery = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(MeliAPIManager.baseURL)/items/\(id)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.setup()
        request.setValue("Bearer \(TokenManager.value)", forHTTPHeaderField: "Authorization")
        return request
    }
}
