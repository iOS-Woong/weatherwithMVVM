//
//  CommonTitleView.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit

class CommonTitleView: UIView {
    
    private let regionLabel = {
       let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let tempLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 120, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let minMaxTempHorizontalStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let maxTempLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let minTempLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: CityWeather) {
        regionLabel.text = data.name
        tempLabel.text = data.temparature.temp.convertCelciusTemp()
        descriptionLabel.text = data.description
        minTempLabel.text = "최저: \(data.temparature.tempMin.convertCelciusTemp())"
        maxTempLabel.text = "최고: \(data.temparature.tempMax.convertCelciusTemp())"
    }

    private func setupViews() {
        self.backgroundColor = .clear
        
        [maxTempLabel, minTempLabel].forEach(minMaxTempHorizontalStackView.addArrangedSubview(_:))
        
        let targetViews = [regionLabel, tempLabel, descriptionLabel, minMaxTempHorizontalStackView]
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            regionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            regionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 10),
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            minMaxTempHorizontalStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            minMaxTempHorizontalStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            minMaxTempHorizontalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        
    }
    
    
}
