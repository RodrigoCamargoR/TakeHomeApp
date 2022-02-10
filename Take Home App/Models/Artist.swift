//
//  Artist.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/7/22.
//

import Foundation

struct SearchResponse: Codable {
    let artists: ArtistsResponse
}

struct ArtistsResponse: Codable {
    var items: [Artist]?
    
    func order(by popularity: Int) {
        
    }
}

struct Artist: Codable {
    let id: String
    let name: String
    let profileImage: [Image]
    let popularity: Int
    let genres: [String]
    let externalUrls: [String:String]
    let followers: Followers
    
    enum CodingKeys: String, CodingKey {
        case id, name, popularity, genres, followers
        case profileImage = "images"
        case externalUrls = "external_urls"
    }
}

struct Followers: Codable {
    let total: Int
}
