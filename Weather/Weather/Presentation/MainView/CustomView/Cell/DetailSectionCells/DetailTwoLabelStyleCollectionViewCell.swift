//
//  DetailTwoLabelStyleCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//

import UIKit

enum DetailItem: Int {
    case sensory, humidity // graph, twoLabel
    case visiblity, sun // twoLabel, graph
    case cloud, pressure // twoLabel, graph
}

class DetailTwoLabelStyleCollectionViewCell: UICollectionViewCell {
    private let mainLabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configure(data: CityWeather, detailItemKind: DetailItem) {
        switch detailItemKind {
        
        case .humidity:
            print(data.temparature.detail.humidity)
            mainLabel.text = "\(data.temparature.detail.humidity)%"
            subLabel.text = data.temparature.detail.humidity.calculateDewPoint(data: data)
        case .visiblity:
            mainLabel.text = "\(data.temparature.detail.visibility / 1000)km"
            subLabel.text = "매우 좋은 가시거리입니다."
        case .cloud:
            mainLabel.text = "\(data.cloud.Cloudiness)%"
            subLabel.text = data.cloud.Cloudiness.calculateCloudness()
        default:
            break
        }
    }
    
    private func setupCellAttributes() {
        self.backgroundColor = .systemFill
        self.layer.cornerRadius = 15
    }
    
    private func setupViews() {
        [mainLabel, subLabel].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            subLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

private extension Int {
    func calculateDewPoint(data: CityWeather) -> String? {
        let currentDoubleTemp = data.temparature.temp.convertCelciusTempDouble()
        
        let doubleHumidity = Double(self) / 100
        let dewPoint = Int(currentDoubleTemp / (doubleHumidity * 1.2212944626))
        let dewPointString = "\(dewPoint)°C"
        
        return "현재 이슬점은 \(dewPointString)입니다."
    }
    
    func calculateCloudness() -> String? {
        switch self {
        case 0..<30:
            return "맑은 상태입니다.."
        case 30..<70:
            return "약간 흐린 상태입니다."
        default:
            return "매우 흐린 상태입니다."
        }
    }
}
