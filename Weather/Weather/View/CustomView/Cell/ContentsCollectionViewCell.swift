//
//  ContentsCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit

class ContentsCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private let citiesWeatherHorizontalStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let citiesLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weatherIconImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let minMaxTempHorizontalStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let minLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weatherSlide = {
       let slider = UISlider()
        return slider
    }()
    
    private let maxLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupSliderThumbAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSliderThumbAttributes() {
        let rect = CGRect(x: 0, y: 0,
                          width: contentView.frame.width * 0.01,
                          height: contentView.frame.height * 0.01)
        weatherSlide.thumbRect(forBounds: rect,
                               trackRect: rect, value: 0)
    }
    
    private func setupViews() {
        [citiesLabel, weatherIconImageView].forEach(citiesWeatherHorizontalStackView.addArrangedSubview(_:))
        [minLabel, weatherSlide, maxLabel].forEach(minMaxTempHorizontalStackView.addArrangedSubview(_:))
        
        [citiesWeatherHorizontalStackView, minMaxTempHorizontalStackView].forEach(contentView.addSubview(_:))
        
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            citiesWeatherHorizontalStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            citiesWeatherHorizontalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            citiesWeatherHorizontalStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.3),
            
            citiesLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            citiesLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.2),
            
            weatherIconImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.1),
            weatherIconImageView.heightAnchor.constraint(equalTo: weatherIconImageView.widthAnchor, multiplier: 1),
            
            minMaxTempHorizontalStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            minMaxTempHorizontalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
//            minMaxTempHorizontalStackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            
            weatherSlide.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.3),
            
            
        ])
    }
    
    func configure(text: String) {
        citiesLabel.text = "Seoul"
        weatherIconImageView.image = UIImage(systemName: "cloud")
        minLabel.text = "16'"
        maxLabel.text = "20'"
    }
    
}
