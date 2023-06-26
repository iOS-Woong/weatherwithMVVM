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
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let weatherImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let minTempLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .systemGray2
        
        return label
    }()
    
    private let chartView = {
        let view = UIView()
        
        view.backgroundColor = .yellow // TODO: Chart 라이브러리 적용하여 삭제할 것
        
        return view
    }()
    
    private let maxTempLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let minMaxChartHorizonStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
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
    
    func configure(_ data: CityWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = data.name.convertCityNameToKr()
            self.maxTempLabel.text = data.temparature.tempMax.convertCelciusTemp()
            self.minTempLabel.text = data.temparature.tempMin.convertCelciusTemp()
        }
    }
    
    func configure(_ image: Data) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(data: image)
        }
    }
    
    private func convertCityNameToKr(with data: CityWeather) -> String? {
        guard let queryItem = QueryItem(rawValue: data.name.lowercased()) else { return nil }
        
        return queryItem.cityNameKr
    }
    
    private func setupViews() {
        [minTempLabel, chartView, maxTempLabel].forEach(minMaxChartHorizonStackView.addArrangedSubview(_:))
        
        let targetViews = [cityLabel, weatherImageView, minMaxChartHorizonStackView]
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            chartView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.08),
            
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 50),
            weatherImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.09),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.9),
            
            minTempLabel.widthAnchor.constraint(equalTo: minMaxChartHorizonStackView.widthAnchor, multiplier: 0.2),
            maxTempLabel.widthAnchor.constraint(equalTo: minMaxChartHorizonStackView.widthAnchor, multiplier: 0.2),
            
            minMaxChartHorizonStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            minMaxChartHorizonStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55),
            minMaxChartHorizonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
