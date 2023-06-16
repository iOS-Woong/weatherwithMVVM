//
//  ContentsCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell, ReusableView {
    private let timeLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "오전 3시" // ForTest
        
        return label
    }()
    
    private let weatherImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "cloud") // ForTest
        imageView.tintColor = .systemBlue
        
        return imageView
    }()
    
    private let tempLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .white
        label.text = "17°"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ data: Forecast) {
        timeLabel.text = data.dt
        tempLabel.text = data.temp.description
    }
    
    private func setupViews() {
        let targetViews = [timeLabel, weatherImageView, tempLabel]
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            weatherImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.9),
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
    }
    
    
}
