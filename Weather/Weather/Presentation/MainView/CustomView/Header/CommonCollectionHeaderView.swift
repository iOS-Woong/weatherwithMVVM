//
//  CityCollectionHeaderView.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/11.
//

import UIKit

class CommonCollectionHeaderView: UICollectionReusableView {
    
    private let calendarFlagImageView = {
       let imageView = UIImageView()
        
        imageView.tintColor = .white
        
        return imageView
    }()
    
    
    private let descriptionLabel = {
       let label = UILabel()
        
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configureHeader(section: Section) {
        switch section {
        case .hourly:
            calendarFlagImageView.image = UIImage(systemName: "clock.badge")
            descriptionLabel.text = "시간별 일기예보"
        case .city:
            calendarFlagImageView.image = UIImage(systemName: "calendar")
            descriptionLabel.text = "10일간의 일기예보"
        case .wind:
            calendarFlagImageView.image = UIImage(systemName: "wind")
            descriptionLabel.text = "바람"
        case .tempMap:
            descriptionLabel.text = "세계온도"
        case .detail:
            descriptionLabel.text = "아직안함"
        }
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
