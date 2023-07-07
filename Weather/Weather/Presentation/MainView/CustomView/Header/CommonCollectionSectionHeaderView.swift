//
//  CommonCollectionSectionHeaderView.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/11.
//

import UIKit

class CommonCollectionSectionHeaderView: UICollectionReusableView {
    
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
    
    func configureHeader(section: Section, item: Int) {
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
            calendarFlagImageView.image = UIImage(systemName: "globe")
            descriptionLabel.text = "세계온도"
        case .detail:
            configureDetailSection(item: item)
        }
    }
    
    private func configureDetailSection(item: Int) {
        guard let itemKind = DetailItem(rawValue: item) else { return }
        
        switch itemKind {
        case .sensory:
            calendarFlagImageView.image = UIImage(systemName: "thermometer.medium")
            descriptionLabel.text = "체감온도"
        case .humidity:
            calendarFlagImageView.image = UIImage(systemName: "humidity")
            descriptionLabel.text = "습도"
        case .visiblity:
            calendarFlagImageView.image = UIImage(systemName: "eye.fill")
            descriptionLabel.text = "가시거리"
        case .sun:
            calendarFlagImageView.image = UIImage(systemName: "sunset.fill")
            descriptionLabel.text = "일출 & 일몰"
        case .cloud:
            calendarFlagImageView.image = UIImage(systemName: "cloud.fill")
            descriptionLabel.text = "흐림정도"
        case .pressure:
            calendarFlagImageView.image = UIImage(systemName: "rectangle.compress.vertical")
            descriptionLabel.text = "기압"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .sectionHeaderColor
        self.layer.cornerRadius = 8
        
        let targetViews = [calendarFlagImageView, descriptionLabel]
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            calendarFlagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            calendarFlagImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55),
            calendarFlagImageView.widthAnchor.constraint(equalTo: calendarFlagImageView.heightAnchor, multiplier: 1.05),
            calendarFlagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: calendarFlagImageView.trailingAnchor, constant: 10),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
