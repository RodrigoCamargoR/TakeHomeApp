//
//  Constants.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/5/22.
//

import Foundation

struct Constants {
    
    struct API {
        static let clientId = "f3dc5706c0304c1a8a35f11db13a722d"
        static let clientSecret = "519f9de2d4734cc0b71281c2f09c93a6"
        static let redirectUri = "https://www.spotify.com/"
        static let authBaseUrl = "https://accounts.spotify.com/authorize"
        static let searchEndpoint = "https://api.spotify.com/v1/search"
        static let artistsEndpoint = "https://api.spotify.com/v1/artists/"
        
        static let authCode = "AQDfJ1ib82F0SwUo5PzkF42idoAAJhDo9xTqTUqUV6-QFrZHgZTvbDNSWXJLEnbbu55YwMCPZb8nEWiMtjPAWMzcZyYFAN1X9VlPZKlmaxzARE0Pp2hcFhRSHrC1WErBpqL1D6hEhVJqG0YXW4xzLqfz2EFHPWxgaova1RjiVKZV-ZnGStxKMq21pbezvtM"
        static let tokenApiUrl = "https://accounts.spotify.com/api/token"
        static let refreshToken = "refresh_token"
        
        static let applicationParameter = "application/x-www-form-urlencoded"
        static let contentTypeHeaderField = "Content-Type"
        static let authHeaderField = "Authorization"
    }
    
    struct Texts {
        static let welcomeMessage = "Welcome!"
    }
    
    struct Errors {
        static let errorGettingBase64String = "There was an error when getting the base64 string"
    }
    
    struct UserDefaults {
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
        static let expiradionDate = "expiration_date"
    }
    
    struct Identifiers {
        static let artistSearch = "ArtistSearchReusableCell"
    }
}
