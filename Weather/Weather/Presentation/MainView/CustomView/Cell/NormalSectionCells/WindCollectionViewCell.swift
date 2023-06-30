//
//  WindCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//

import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    private let windSpeedLabel = {
       let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let descriptionLabel = {
       let label = UILabel()

        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)

        return label
    }()
    
    private let graphView = {
       let view = UIView()
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: CityWeather) {
        let roundedSpeed = Int(data.wind.speed)
        
        windSpeedLabel.text = "\(data.wind.speed) m/s"
        descriptionLabel.text =
        "현재의 풍속은 \(roundedSpeed) m/s 이며,\n바람의 방향은 \(data.wind.deg.convertWindDirection())입니다."
    }
    
    private func setupViews() {
        let targetViews = [windSpeedLabel, descriptionLabel, graphView]
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            windSpeedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            descriptionLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            graphView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            graphView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            graphView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            graphView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
}

private extension Int {
    func convertWindDirection() -> String {
        let directions = ["북풍", "북동풍", "동풍", "남동풍", "남풍", "남서풍", "서풍", "북서풍"]
        
        let doubleSelf = Double(self)
        let adjustedAngle = doubleSelf.truncatingRemainder(dividingBy: 360)
        let index = Int((adjustedAngle + 22.5) / 45) % 8
        
        return directions[index]
    }
}
