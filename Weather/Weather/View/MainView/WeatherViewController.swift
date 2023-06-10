//
//  ViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let viewModel: MainViewModel
        
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
    
}
