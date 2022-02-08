//
//  SpotifyManager+RefreshToken.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import Foundation

extension SpotifyManager {
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: Constants.UserDefaults.refreshToken)
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: Constants.UserDefaults.expiradionDate) as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    func refreshIfNeeded(completion: @escaping ((Bool) -> Void)) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard
            let refreshToken = refreshToken,
            let url = URL(string: Constants.API.tokenApiUrl)
        else { return }
        
        let components = getBodyParametersForRefreshToken(withNewToken: refreshToken)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue(Constants.API.applicationParameter, forHTTPHeaderField: Constants.API.contentTypeHeaderField)
        
        guard let base64String = getEncodedStringToken()
        else {
            print(Constants.Errors.errorGettingBase64String)
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: Constants.API.authHeaderField)
        
        let datatask = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil
            else {
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(AuthResponse.self, from: data)
                
                print("Successfully refreshed token!")
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error)
                completion(false)
            }
        }
        datatask.resume()
    }
    
    //MARK: - Methods
    private func getBodyParametersForRefreshToken(withNewToken refreshToken: String) -> URLComponents {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: Constants.API.refreshToken),
            URLQueryItem(name: Constants.API.refreshToken, value: refreshToken)
        ]
        return components
    }
    
    private func getEncodedStringToken() -> String? {
        let basicToken = (Constants.API.clientId+":"+Constants.API.clientSecret).data(using: .utf8)

        return basicToken?.base64EncodedString()
    }
    
}
