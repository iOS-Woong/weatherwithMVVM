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
        
        imageView.image = UIImage(systemName: "cloud")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(tempMapImageView)
        
        NSLayoutConstraint.activate([
            tempMapImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tempMapImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempMapImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tempMapImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}
