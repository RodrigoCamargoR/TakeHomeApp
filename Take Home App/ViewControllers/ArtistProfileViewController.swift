//
//  ArtistProfileViewController.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import UIKit
import Accelerate

class ArtistProfileViewController: UIViewController {
    
    
    //MARK: - Properties

    private var controller: ArtistController?
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var artistName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 30)
        label.textColor = .white
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var artistGenre: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var songsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .darkGray
        
        return tableView
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        guard let controller = controller else { return }

        controller.fetchSongs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
        setUpProfile()
    }
    
    //MARK: - Setups
    private func setupViews() {
        view.backgroundColor = .darkGray
        songsTableView.delegate = self
        songsTableView.dataSource = self
        
        view.addSubview(profileImage)
        view.addSubview(artistName)
        view.addSubview(artistGenre)
        view.addSubview(songsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
            
            artistName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            artistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            artistGenre.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 5),
            artistGenre.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistGenre.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            songsTableView.topAnchor.constraint(equalTo: artistGenre.bottomAnchor, constant: 60),
            songsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            songsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
    }
    
    //MARK: - Methods
    func setArtist(artist: Artist) {
        controller = ArtistController(viewController: self)
        guard let controller = controller else { return }

        controller.setArtist(with: artist)
    }

    private func setUpProfile() {
        guard
            let controller = controller,
            let artist = controller.getArtist()
        else { return }
        
        artistName.text = artist.name
        
        artist.genres.forEach { genre in
            if artistGenre.text == nil {
                artistGenre.text = "\(genre.capitalized)"
            } else {
                artistGenre.text = "\(artistGenre.text ?? ""), \(genre.capitalized)"
            }
        }

        guard artist.profileImage.count > 0
        else {
            profileImage.image = UIImage(named: "No-Image")
            return
        }

        let urlString = artist.profileImage[0].url
        guard let url = URL(string: urlString) else { return }
        
        profileImage.kf.setImage(with: url)
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.songsTableView.reloadData()
        }
    }
}

extension ArtistProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
}

extension ArtistProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let controller = controller else { return 0 }
        let songs = controller.getSongs()
        
        return songs.count > 5 ? 5 : songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath)
        
        guard
            let songCell = cell as? SongTableViewCell,
            let controller = controller
        else { return cell }
        
        let currentSong = controller.getSong(from: indexPath.row)
        songCell.setupCell(with: currentSong)
        
        return songCell
    }
    
}
