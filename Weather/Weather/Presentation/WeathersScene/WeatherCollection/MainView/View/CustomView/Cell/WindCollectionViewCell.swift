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
        
        label.text = "55m/s"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let descriptionLabel = {
       let label = UILabel()

        label.text = "현재의 풍속은 33m/s 이며, \n이런이런상황입니다."
        label.textColor = .white

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
