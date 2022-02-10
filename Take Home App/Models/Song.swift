//
//  Song.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation

struct TracksResponse: Codable {
    let tracks: [Song]
}

struct Song: Codable {
    let id: String
    let artists: [SongArtist]
    let album: SongAlbum
    let name: String
    let popularity: Int
    let durationMiliSecs: Int

    private enum CodingKeys: String, CodingKey {
        case id, name, artists, popularity, album
        case durationMiliSecs = "duration_ms"
    }
    
    func getDurationInMinutes() -> String {
        let totalSeconds = durationMiliSecs / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds - hours) / 60
        let seconds = totalSeconds - (hours * 3600 + minutes * 60)
        
        return seconds < 10 ? "\(minutes):0\(seconds)" : "\(minutes):\(seconds)"
    }
}

struct SongArtist: Codable {
    let id: String
    let name: String
}

struct SongAlbum: Codable {
    let id: String
    let name: String
    let images: [Image]
}
