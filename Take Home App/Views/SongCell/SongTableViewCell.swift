//
//  SongTableViewCell.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/10/22.
//

import UIKit
import Kingfisher

class SongTableViewCell: UITableViewCell {
    
    static let identifier = "songCellReusableIdentifier"

    private let image: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 18)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 16)
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupCell(with song: Song) {
        nameLabel.text = song.name
        durationLabel.text = song.getDurationInMinutes()
        
        guard let url = URL(string: song.album.images[0].url) else { return }
        image.kf.setImage(with: url)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
        image.layer.cornerRadius = 5
    }
    
    private func setupViews() {
        contentView.backgroundColor = .darkGray
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(durationLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            image.widthAnchor.constraint(equalToConstant: 54),
            image.heightAnchor.constraint(equalToConstant: 54),
            
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
            durationLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 3),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            durationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            durationLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

}
