//
//  InitialController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import Foundation
import UIKit

class InitialController {
    
    var viewController: ViewController
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func handleSignIn(success: Bool) {
        guard success else {
            viewController.showErrorAlert()
            return
        }
        
        let vc = HomeViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true)
    }
}
