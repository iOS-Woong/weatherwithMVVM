//
//  ContentCollectionHeaderView.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit

class ContentCollectionHeaderView: UICollectionReusableView, ReusableView {
    private let contentVerticalStackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    private let seoulNameLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private let seoulTempLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private let seoulDescLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()

    private let minMaxHorizontalStackView: UIStackView = {
       let stackView = UIStackView()
        
        return stackView
    }()
    
    private let seoulMinLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private let seoulMaxLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [seoulNameLabel, seoulTempLabel, seoulDescLabel, minMaxHorizontalStackView].forEach(contentVerticalStackView.addArrangedSubview(_:))
        [seoulMinLabel, seoulMaxLabel].forEach(minMaxHorizontalStackView.addArrangedSubview(_:))
        
        addSubview(contentVerticalStackView)
        
        NSLayoutConstraint.activate([
            contentVerticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentVerticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentVerticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentVerticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure() {
        seoulNameLabel.text = "네임"
        seoulTempLabel.text = "템프"
        seoulDescLabel.text = "디스크립션"
        seoulMinLabel.text = "민"
        seoulMaxLabel.text = "맥스"
    }
    
}
