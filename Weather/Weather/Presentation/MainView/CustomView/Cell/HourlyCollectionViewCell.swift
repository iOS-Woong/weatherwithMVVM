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
        
        return label
    }()
    
    private let weatherImageView = {
       let imageView = UIImageView()
        
        imageView.tintColor = .systemBlue
        
        return imageView
    }()
    
    private let tempLabel = {
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
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
    
    func configure(text data: Forecast) {
        DispatchQueue.main.async {
            self.timeLabel.text = data.dt.convertUtcToKst()
            self.tempLabel.text = data.temp.convertCelciusTemp()
        }
    }
    
    func configure(image data: Data) {
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(data: data)
        }
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

private extension String {
    func convertUtcToKst() -> String? {
        let utcDateString = self

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        if let utcDate = dateFormatter.date(from: utcDateString) {
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a hh시"
            
            return dateFormatter.string(from: utcDate)
        }
        return nil
    }
}

private extension Double {
    func convertCelciusTemp() -> String {
        let celciusInt = Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self))
        
        return celciusInt.description + "°"
    }
}

