//
//  GradientProgressView.swift
//  Weather
//
//  Created by 서현웅 on 2023/07/04.
//

import UIKit

class GradientProgressView: UIProgressView {

    private lazy var gradientLayer: CAGradientLayer = initGradientLayer()
    var gradientColors: [CGColor] = [
        UIColor.systemYellow.cgColor,
        UIColor.systemOrange.cgColor,
        UIColor.systemRed.cgColor
    ]
    private let cornerRadius: CGFloat = 3.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientLayer()
    }
    
    private func setupAttributes() {
        self.layer.cornerRadius = cornerRadius
        
        progressTintColor = UIColor.clear
        gradientLayer.colors = gradientColors
        gradientLayer.cornerRadius = cornerRadius

        self.layer.addSublayer(gradientLayer)
    }
    
    private func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 5
        gradientLayer.masksToBounds = true
        
        return gradientLayer
    }
    
    private func updateGradientLayer() {
        gradientLayer.frame = sizeByPercentage(originalRect: bounds,
                                               width: CGFloat(progress))
    }
    
    private func sizeByPercentage(originalRect: CGRect, width: CGFloat) -> CGRect {
        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
        return CGRect(origin: originalRect.origin, size: newSize)
    }
    
}
