//
//  DetailPressureGraphCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/07/05.
//

import UIKit

class DetailPressureGraphCollectionViewCell: UICollectionViewCell {
    private let graphView = {
        let view = CircleProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let highLabel = {
        let label = UILabel()
        label.text = "고"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let lowLabel = {
        let label = UILabel()
        label.text = "저"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let labelHorizontalStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellAttributes()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Temparature) {
        let pressure = Double(data.detail.pressure)
        graphView.progress = calculateValue(pressure: pressure)
    }
    
    private func calculateValue(pressure: Double) -> Double {
        let subtractionDefaultValue = pressure - 950
        return subtractionDefaultValue * 0.01
    }
    
    private func setupCellAttributes() {
        self.backgroundColor = .decoreateItemViewColor
        self.layer.cornerRadius = 15
    }
    
    private func setupViews() {
        [highLabel, lowLabel].forEach(labelHorizontalStackView.addArrangedSubview(_:))
        [graphView, labelHorizontalStackView].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            graphView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            graphView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            graphView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            graphView.heightAnchor.constraint(equalTo: graphView.widthAnchor),
            
            labelHorizontalStackView.topAnchor.constraint(equalTo: graphView.bottomAnchor),
            labelHorizontalStackView.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.5),
            labelHorizontalStackView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor)
        ])
    }
}
