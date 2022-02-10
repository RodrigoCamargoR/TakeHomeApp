//
//  HomeViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/6/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Properties
    private lazy var controller = HomeController(viewController: self)
    
    private var signOutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "logo_white")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        navigationController?.navigationBar.isHidden = true
        
        setupConstraints()
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
    }
    
    //MARK: - Setups
    private func setupViews() {
        searchBar.delegate = self
        
        view.addSubview(signOutButton)
        view.addSubview(logoImage)
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
            
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchArtistLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80),
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
        
        controller.searchArtists(with: query)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func signOut() {
        controller.signOut()
    }
    
    func performSignOut() {
        let confirmationAlert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let cancelSignOut = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmSignOut = UIAlertAction(title: "Confirm", style: .destructive) { [weak self] _ in
            let navController = UINavigationController(rootViewController: ViewController())
            navController.modalPresentationStyle = .fullScreen
            self?.present(navController, animated: true)
        }
        confirmationAlert.addAction(cancelSignOut)
        confirmationAlert.addAction(confirmSignOut)
        present(confirmationAlert, animated: true)
    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.searchTextField.text else { return }
        searchButton.isUserInteractionEnabled = !query.isEmpty
    }
    
}
