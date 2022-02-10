//
//  SpotifyManager+Songs.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation

extension SpotifyManager {
    
    func searchSongs(by artistID: String, completion: @escaping (Result<TracksResponse, Error>) -> Void) {
        
        let urlString = "\(Constants.API.artistsEndpoint)\(artistID)/top-tracks?market=ES"
        guard let url = URL(string: urlString) else { return }
        
        createRequest(with: url, type: .GET) { request in
            let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
                guard
                    let data = data,
                    error == nil
                else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TracksResponse.self, from: data)
                    
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            dataTask.resume()
        }
    }
    
}
