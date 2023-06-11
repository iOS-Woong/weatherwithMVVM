//
//  CityCollectionHeaderView.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/11.
//

import UIKit

class CityCollectionHeaderView: UICollectionReusableView {
    
    private let calendarFlagImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .white
        
        return imageView
    }()
    
    
    private let descriptionLabel = {
       let label = UILabel()
        
        label.text = "10일간의 일기예보"
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let targetViews = [calendarFlagImageView, descriptionLabel]
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            calendarFlagImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05),
            calendarFlagImageView.heightAnchor.constraint(equalTo: calendarFlagImageView.widthAnchor),
            calendarFlagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: calendarFlagImageView.trailingAnchor, constant: 10),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
}
