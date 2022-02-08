//
//  AuthResponse.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
    
    private enum CodingKeys: String, CodingKey {
        case scope
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}
