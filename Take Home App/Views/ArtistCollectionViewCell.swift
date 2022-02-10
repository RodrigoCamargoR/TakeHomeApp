//
//  ArtistCollectionViewCell.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/8/22.
//

import UIKit
import Kingfisher

class ArtistCollectionViewCell: UICollectionViewCell {
    
    private let artistImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private let artistName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(artistImage)
        artistImage.addSubview(artistName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(artist: Artist) {
        setupCellView()
        
        artistName.text = artist.name
        
        let profileImageUrlString = artist.profileImage[0].url
        guard let profileImageUrl = URL(string: profileImageUrlString) else { return }
        artistImage.kf.setImage(with: profileImageUrl)
    }
    
    func setupCellView() {
        layer.cornerRadius = 10
        backgroundColor = .lightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            artistImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            artistImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artistImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            artistName.leadingAnchor.constraint(equalTo: artistImage.leadingAnchor, constant: 5),
            artistName.trailingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: -5),
            artistName.bottomAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: -5)
        ])
    }

}
