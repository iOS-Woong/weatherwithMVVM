//
//  CityCollectionHeaderView.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/11.
//

import UIKit

class CityCollectionHeaderView: UICollectionReusableView {
    
    private let calendarFlagImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "calendar")
        
        return imageView
    }()
    
    private let descriptionLabel = {
       let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let targetViews = [calendarFlagImageView, descriptionLabel]
        
        targetViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
        ])
        
    }
}
