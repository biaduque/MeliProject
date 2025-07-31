//
//  TokenResponse.swift
//  MeliProject
//
//  Created by Beatriz Duque on 29/07/25.
//

struct TokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let refreshToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case refreshToken = "refresh_token"
    }
}
