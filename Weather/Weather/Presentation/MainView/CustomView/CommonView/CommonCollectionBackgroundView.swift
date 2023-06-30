//
//  CommonCollectionBackgroundView.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/28.
//

import UIKit

class CommonCollectionBackgroundView: UICollectionReusableView, ReusableView {
    private let backDecorateView = {
        let view = UIView()
        
        view.backgroundColor = .quaternarySystemFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
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

        self.addSubview(backDecorateView)
        
        NSLayoutConstraint.activate([
            backDecorateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backDecorateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backDecorateView.topAnchor.constraint(equalTo: self.topAnchor),
            backDecorateView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
