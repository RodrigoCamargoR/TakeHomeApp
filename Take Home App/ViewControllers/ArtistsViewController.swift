//
//  ArtistsViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/8/22.
//

import UIKit

class ArtistsViewController: UIViewController {

    //MARK: - Properties
    private lazy var artistsTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Artists found for: \(query ?? "")"
        label.font = UIFont(name: "Arial", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.artistSearch)
        
        return collection
    }()
    
    var artists: [Artist]?
    var query: String?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
        collectionView.reloadData()
    }

    //MARK: - Setups
    private func setupViews() {
        view.backgroundColor = .darkGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(artistsTitle)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            artistsTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            artistsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            artistsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: artistsTitle.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let artists = artists else { return }
        print(artists[indexPath.row].name)
    }
}


extension ArtistsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let artists = artists else { return 0 }
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.artistSearch, for: indexPath)
        
        guard
            let artistCell = cell as? ArtistCollectionViewCell,
            let artists = artists
        else { return cell }
        
        artistCell.configureCell(artist: artists[indexPath.row])
        
        return artistCell
    }
    
}

extension ArtistsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let collectionHeight = collectionView.frame.height
        return CGSize(width: screenWidth / 3.6, height: collectionHeight / 4.5)
    }
}