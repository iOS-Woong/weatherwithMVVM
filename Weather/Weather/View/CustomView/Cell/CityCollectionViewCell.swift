//
//  CityCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/11.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    private let cityLabel = {
        let label = UILabel()
        
        label.text = "대구" // test
        label.textColor = .white
        
        return label
    }()
    
    private let weatherImageView = {
        let imageView = UIImageView()
        
        
        return imageView
    }()
    
    private let minTempLabel = {
        let label = UILabel()
        
        label.text = "-17°"
        label.textColor = .white
        
        return label
    }()
    
    private let chartView = {
        let view = UIView()
        
        view.backgroundColor = .yellow // TODO: Chart 라이브러리 적용하여 삭제할 것
        
        return view
    }()
    
    private let maxTempLabel = {
        let label = UILabel()
        
        label.text = "34°"
        label.textColor = .white
        
        return label
    }()
    
    private let minMaxChartHorizonStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [maxTempLabel, chartView, minTempLabel].forEach(minMaxChartHorizonStackView.addArrangedSubview(_:))
        
        let targetViews = [cityLabel, weatherImageView, minMaxChartHorizonStackView]
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            weatherImageView.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5),
            weatherImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.9),
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            minMaxChartHorizonStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            minMaxChartHorizonStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            minMaxChartHorizonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
    }
    
}
