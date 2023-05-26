//
//  ContentsCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit

class ContentsCollectionViewCell: UICollectionViewCell, ReusableView {
    private let testLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            testLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    func configure(text: String) {
        testLabel.text = text
    }
    
}
