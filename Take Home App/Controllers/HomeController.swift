//
//  HomeController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation

class HomeController {
    
    private var viewController: HomeViewController
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func searchArtists(with query: String) {
        
        let vc = ArtistsViewController()
        vc.modalPresentationStyle = .popover
        
        SpotifyManager.shared.searchArtists(with: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    vc.query = query
                    if let artists = response.artists.items {
                        vc.artists = artists.sorted(by: { $0.popularity > $1.popularity } )
                        self?.viewController.navigationController?.pushViewController(vc, animated: true)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func signOut() {
        SpotifyManager.shared.signOut { success in
            guard success else { return }
            viewController.performSignOut()
        }
    }
    
}
