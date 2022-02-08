//
//  SpotifyManager.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/5/22.
//

import Foundation

final class SpotifyManager {
    
    //MARK: - Singleton
    static let shared = SpotifyManager()
    
    //MARK: - Properties
    var loginUrl: URL? = {
        let baseUrl = Constants.API.authBaseUrl
        let parameters =    "?response_type=code" +
                            "&client_id=\(Constants.API.clientId)" +
                            "&scope=user-read-private" +
                            "&redirect_uri=\(Constants.API.redirectUri)" +
                            "&show_dialog=TRUE"
        
        let stringUrl = baseUrl + parameters
        
        return URL(string: stringUrl)
    }()
    
    var isSignedIn: Bool {
        let accessToken = UserDefaults.standard.string(forKey: Constants.UserDefaults.accessToken)
        return accessToken != nil
    }

    func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        SpotifyManager.shared.withValidToken { token in
            guard let apiUrl = url else { return }
            
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: Constants.API.authHeaderField)
            request.httpMethod = type.rawValue
            completion(request)
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
}
