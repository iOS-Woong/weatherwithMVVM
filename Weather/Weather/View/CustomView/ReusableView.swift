//
//  ReusableView.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/26.
//

import UIKit.UIView

protocol ReusableView: UIView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
