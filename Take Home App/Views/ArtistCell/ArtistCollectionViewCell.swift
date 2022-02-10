//
//  ArtistCollectionViewCell.swift
//  Take Home App
//
//  Created by Rodrigo Camargo on 2/8/22.
//

import UIKit
import Kingfisher

class ArtistCollectionViewCell: UICollectionViewCell {
    
    private lazy var artistImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let artistName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: Constants.Fonts.arial, size: 17)
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
        
        guard artist.profileImage.count > 0 else {
            artistImage.image = UIImage(named: "No-Image")
            return
        }
        
        let profileImageUrlString = artist.profileImage[0].url
        guard let profileImageUrl = URL(string: profileImageUrlString) else { return }
        artistImage.kf.setImage(with: profileImageUrl)
    }
    
    func setupCellView() {
        layer.cornerRadius = 10
        backgroundColor = .lightGray
        
        guard
            let sublayersCount = artistImage.layer.sublayers?.count,
            sublayersCount < 3
        else { return }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = artistImage.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.2]

        artistImage.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistImage.layer.cornerRadius = 10
        
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
