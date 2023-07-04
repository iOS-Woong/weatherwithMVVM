//
//  TempMapCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//

import UIKit

class TempMapCollectionViewCell: UICollectionViewCell {
    
    private let tempMapImageView = {
       let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Data) {
        DispatchQueue.main.async {
            self.tempMapImageView.image = UIImage(data: data)
        }
    }
    
    private func setupViews() {
        
        contentView.addSubview(tempMapImageView)
        
        NSLayoutConstraint.activate([
            tempMapImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            tempMapImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            
            tempMapImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempMapImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
    }
    
}
