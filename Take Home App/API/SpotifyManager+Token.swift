//
//  SpotifyManager+Token.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import Foundation

extension SpotifyManager {
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: Constants.UserDefaults.accessToken)
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
    
    func cacheToken(result: AuthResponse) {
        UserDefaults.standard.set(result.accessToken, forKey: Constants.UserDefaults.accessToken)
        
        let expirationDate = Date().addingTimeInterval(TimeInterval(result.expiresIn))
        UserDefaults.standard.set(expirationDate, forKey: Constants.UserDefaults.expiradionDate)
        
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.set(refreshToken, forKey: Constants.UserDefaults.refreshToken)
        }
    }
    
    func withValidToken(completion: @escaping (String) -> Void) {
        if shouldRefreshToken {
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
}
