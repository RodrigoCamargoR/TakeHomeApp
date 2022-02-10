//
//  ViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var controller = InitialController(viewController: self)
    
    private var welcomeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.text = Constants.Texts.welcomeMessage
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var logoImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "original_black")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
    }
    
    //MARK: - Setups
    private func setupViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(logoImage)
        view.addSubview(loginButton)
        
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor),
            logoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Actions
    @objc private func didTapLogIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.controller.handleSignIn(success: success)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: Constants.Errors.oops, message: Constants.Errors.errorLogingIn, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.Texts.dismissButton, style: .cancel, handler: nil)
        alert.addAction(dismiss)
        
        present(alert, animated: true)
    }
}

