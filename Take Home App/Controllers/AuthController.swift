//
//  AuthController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation

class AuthController {
    
    private var viewController: AuthViewController
    
    init(viewController: AuthViewController) {
        self.viewController = viewController
    }
    
    func exchangeCodeForToken(_ code: String) {
        SpotifyManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            self?.viewController.completionHandler?(success)
        }
    }
    
}
