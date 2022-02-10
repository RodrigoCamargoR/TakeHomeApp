//
//  HomeViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Properties
    private var signOutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var welcomeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 38)
        label.text = "Welcome to\nTake Home App"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var searchArtistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 20)
        label.text = "Look for your favorite singer!"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search artist"
        searchBar.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .darkGray
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtosWasTapped), for: .touchUpInside)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
        navigationController?.navigationBar.isHidden = true
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }
    
    //MARK: - Setups
    private func setupViews() {
        searchBar.delegate = self
        
        view.addSubview(signOutButton)
        view.addSubview(welcomeLabel)
        view.addSubview(searchArtistLabel)
        view.addSubview(searchBar)
        view.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.widthAnchor.constraint(equalToConstant: 100),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchArtistLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 120),
            searchArtistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchArtistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchBar.topAnchor.constraint(equalTo: searchArtistLabel.bottomAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    //MARK: - Actions
    @objc private func searchButtosWasTapped() {
        view.endEditing(true)
        guard
            let query = searchBar.searchTextField.text,
            !query.isEmpty
        else { return }
        
        let vc = ArtistsViewController()
        vc.modalPresentationStyle = .popover
        
        SpotifyManager.shared.searchArtists(with: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    vc.query = query
                    if let artists = response.artists.items {
                        vc.artists = artists.sorted(by: { $0.popularity > $1.popularity } )
                    } else {
                        vc.artists = nil
                    }
                    self?.navigationController?.pushViewController(vc, animated: true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func signOut() {

        SpotifyManager.shared.signOut { [weak self] success in
            guard success else { return }
            let confirmationAlert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            let cancelSignOut = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confirmSignOut = UIAlertAction(title: "Confirm", style: .destructive) { _ in
                let navController = UINavigationController(rootViewController: ViewController())
                navController.modalPresentationStyle = .fullScreen
                self?.present(navController, animated: true)
            }
            confirmationAlert.addAction(cancelSignOut)
            confirmationAlert.addAction(confirmSignOut)
            self?.present(confirmationAlert, animated: true)
        }

    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.searchTextField.text else { return }
        
        searchButton.isUserInteractionEnabled = !query.isEmpty
    }
    
}
