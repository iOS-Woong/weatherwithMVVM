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
        
        view.trackColor = #colorLiteral(red: 0.1977782398, green: 0.1977782398, blue: 0.1977782398, alpha: 0.5)
        view.gradients = [#colorLiteral(red: 0, green: 0.6588235294, blue: 0.7725490196, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 0.4941176471, alpha: 1)]
        view.lineDashPattern = [4, 2]
        view.textColor = .white
        view.lineHeight = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        print(data.detail.pressure)
        graphView.progress = 0.7
    }
    
    private func setupCellAttributes() {
        self.backgroundColor = .systemFill
        self.layer.cornerRadius = 15

    }
    
    private func setupViews() {
        contentView.addSubview(graphView)
        
        NSLayoutConstraint.activate([
            graphView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            graphView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            graphView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            graphView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
