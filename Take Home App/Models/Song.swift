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
        
        return "\(minutes):\(seconds)"
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

//{
//    "artists": [
//        {
//            "external_urls": {
//                "spotify": "https://open.spotify.com/artist/0du5cEVh5yTK9QJze8zA0C"
//            },
//            "href": "https://api.spotify.com/v1/artists/0du5cEVh5yTK9QJze8zA0C",
//            "id": "0du5cEVh5yTK9QJze8zA0C",
//            "name": "Bruno Mars",
//            "type": "artist",
//            "uri": "spotify:artist:0du5cEVh5yTK9QJze8zA0C"
//        }
//    ],
//    "disc_number": 1,
//    "duration_ms": 233478,
//    "explicit": false,
//    "external_ids": {
//        "isrc": "USAT21203287"
//    },
//    "external_urls": {
//        "spotify": "https://open.spotify.com/track/3w3y8KPTfNeOKPiqUTakBh"
//    },
//    "href": "https://api.spotify.com/v1/tracks/3w3y8KPTfNeOKPiqUTakBh",
//    "id": "3w3y8KPTfNeOKPiqUTakBh",
//    "is_local": false,
//    "is_playable": true,
//    "name": "Locked out of Heaven",
//    "popularity": 88,
//    "preview_url": "https://p.scdn.co/mp3-preview/c647489f28d840b545b90e10067012f504dc7b68?cid=774b29d4f13844c495f206cafdad9c86",
//    "track_number": 2,
//    "type": "track",
//    "uri": "spotify:track:3w3y8KPTfNeOKPiqUTakBh"
//}
