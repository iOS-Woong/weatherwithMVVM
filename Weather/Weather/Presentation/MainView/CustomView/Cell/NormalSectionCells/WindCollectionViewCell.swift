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
    
    private let usualLabel = {
       let label = UILabel()
        label.text = "보통"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    
    private let attensionLabel = {
       let label = UILabel()
        label.text = "주의"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    
    private let warningLabel = {
       let label = UILabel()
        label.text = "경고"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    
    private let labelHorizontalStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    private let graphView = {
       let progressView = GradientProgressView()
        return progressView
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
        
        let progressValue = calculatePercentage(data: data.wind)
        graphView.setProgress(progressValue, animated: true)
    }
    
    private func calculatePercentage(data: WindInfo) -> Float {
        let floatSpeed = Float(data.speed)
        return floatSpeed / 30
    }
    
    private func setupViews() {
        let addArrangeTargetView = [usualLabel, attensionLabel, warningLabel]
        let targetViews = [windSpeedLabel, descriptionLabel, graphView, labelHorizontalStackView]
        
        addArrangeTargetView.forEach(labelHorizontalStackView.addArrangedSubview(_:))
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            windSpeedLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            
            graphView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            graphView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            graphView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            graphView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            
            labelHorizontalStackView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
            labelHorizontalStackView.widthAnchor.constraint(equalTo: graphView.widthAnchor),
            labelHorizontalStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            labelHorizontalStackView.bottomAnchor.constraint(equalTo: graphView.topAnchor, constant: -10),
            
            usualLabel.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.26),
            attensionLabel.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.30),
        ])
    }
    
    func multiplier() {
        
        
        
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
