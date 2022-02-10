//
//  ArtistController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation

class ArtistController {
    
    private var artist: Artist?
    private var artistSongs: [Song]?
    
    private var viewController: ArtistProfileViewController
    
    init(viewController: ArtistProfileViewController) {
        self.viewController = viewController
    }
    
    func setArtist(with artist: Artist) {
        self.artist = artist
    }
    
    func getArtist() -> Artist? {
        guard let artist = artist else { return nil }

        return artist
    }
    
    func getSongs() -> [Song] {
        guard let artistSongs = artistSongs else { return [] }

        return artistSongs
    }
    
    func getSong(from position: Int) -> Song? {
        guard let artistSongs = artistSongs else { return nil }
        
        return artistSongs[position]
    }
    
    func fetchSongs() {
        guard let artist = artist else { return }

        SpotifyManager.shared.searchSongs(by: artist.id) { [weak self] result in
            switch result {
            case .success(let response):
                self?.artistSongs = response.tracks
                self?.viewController.reloadTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
