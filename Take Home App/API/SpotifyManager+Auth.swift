//
//  SpotifyManager+Auth.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import Foundation

extension SpotifyManager {
    
    func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: Constants.API.tokenApiUrl) else { return }
        
        let components = getBodyParametersForTokenExchange(withCode: code)
        
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
    private func getBodyParametersForTokenExchange(withCode code: String) -> URLComponents {
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.API.redirectUri)
        ]
        return components
    }
    
    private func getEncodedStringToken() -> String? {
        let basicToken = (Constants.API.clientId+":"+Constants.API.clientSecret).data(using: .utf8)
        
        return basicToken?.base64EncodedString()
    }
}
