//
//  SpotifyManager+SearchArtist.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import Foundation

extension SpotifyManager {
    
    func searchArtists(with  query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        var urlString = "\(Constants.API.searchEndpoint)"
        urlString = "\(urlString)?type=artist"
        urlString = "\(urlString)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
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
                    let result = try decoder.decode(SearchResponse.self, from: data)
                    
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
