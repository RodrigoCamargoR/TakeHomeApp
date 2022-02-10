//
//  ViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private var welcomeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.text = Constants.Texts.welcomeMessage
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        view.addSubview(loginButton)
        
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Actions
    @objc private func didTapLogIn() {
        print("LoginTapped")
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            showErrorAlert()
            return
        }
        
        let vc = HomeViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Oops", message: "Something when wrong logging in", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        
        present(alert, animated: true)
    }
}

