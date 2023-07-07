//
//  DetailSensoryGraphCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/07/05.
//

import UIKit

class DetailSensoryGraphCollectionViewCell: UICollectionViewCell {
    private let mainLabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
        return label
    }()
    
    private let secondLabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    private let graphView = {
       let progressView = GradientProgressView()
        return progressView
    }()
    
    private let thirdLabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellAttributes()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: CityWeather) {
        let sensoryTemp = data.temparature.sensoryTemp
        let celciusTempDouble = sensoryTemp.convertCelciusTempDouble()
        
        mainLabel.text = sensoryTemp.convertCelciusTemp()
        secondLabel.text = celciusTempDouble.sensoryTempDegree().0
        thirdLabel.text = celciusTempDouble.sensoryTempDegree().1
        
        let progressValue = calculatePercnetage(celciusTempDouble)
        graphView.setProgress(progressValue, animated: true)
    }
    
    private func calculatePercnetage(_ temp: Double) -> Float {
        return Float(temp - (-20)) / (40 - (-20))
    }
    
    private func setupCellAttributes() {
        self.backgroundColor = .decoreateItemViewColor
        self.layer.cornerRadius = 15
    }
    
    private func setupViews() {
        let targetViews = [mainLabel, secondLabel, graphView, thirdLabel]
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            secondLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            
            graphView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            graphView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03),
            graphView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 10),
            graphView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            thirdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            thirdLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

private extension Double {
    func sensoryTempDegree() -> (String, String) {
        switch self {
        case -15.4 ..< -10.5:
            return ("경고", "장시간 외출 시,\n동상의 위험이 있습니다.\n가급적 실내에서 활동하세요")
        case -10.5 ..< -3.2:
            return ("주의", "저체온증 위험이 있습니다.\n외출시 방풍 가능한\n옷을 여러겹 껴입으세요")
        case -3.2 ..< 31.0:
            return ("보통", "외부에서\n활동하시기에\n매우 적절한 온도입니다")
        case 31.0 ..< 33.0:
            return ("이상", "더운 날씨입니다.\n온열질환 민감군과 작업강도가\n높은 작업은 주의하세요")
        case 33.0 ..< 35.0:
            return ("주의", "폭염입니다.무더위\n시간대(14~17시)에는\n야외작업시간을 조정하세요")
        case 35.0 ..< 38:
            return ("경고", "심한 폭염입니다.\n무더위 시간대(14~17시)에는\n옥외작업을 중단하세요")
        default:
            return ("위험", "위험합니다.\n가급적 외출을 자제하세요.")
        }
    }
}
