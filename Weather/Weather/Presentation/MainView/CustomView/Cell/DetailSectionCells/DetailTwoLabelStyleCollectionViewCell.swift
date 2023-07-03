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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel = {
       let label = UILabel()
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
    
    func configure(data: CityWeather) {
        mainLabel.text = "20 test"
        subLabel.text = "sublabel tests"
    }
    
    private func setupCellAttributes() {
        self.backgroundColor = .systemFill
        self.layer.cornerRadius = 15
    }
    
    private func setupViews() {
        [mainLabel, subLabel].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            subLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
