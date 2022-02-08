//
//  AuthViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {

    //MARK: - Properties
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()
    
    var completionHandler: ((Bool) -> Void)?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupWebview()
    }
    
    //MARK: - Setups
    private func setupViews() {
        title = "Sign in"
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.frame = view.bounds
    }
    
    private func setupWebview() {
        webView.navigationDelegate = self
        
        guard let url = SpotifyManager.shared.loginUrl else { return }
        webView.load(URLRequest(url: url))
    }

}

//MARK: - Extensions
extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        
        SpotifyManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            self?.completionHandler?(success)
        }
    }
}
