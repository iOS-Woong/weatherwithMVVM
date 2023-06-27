//
//  PageViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/26.
//

import UIKit

class PageViewController: UIViewController {
    private let usecase = ProcessWeatherUsecase()
    private var contentsViewControllers = [UIViewController]()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAttributes()
        setupViews()
    }
    
    private func setupViewControllers() {
        usecase.fetchAllCitiesCurrentWeather {
            for page in Page.allCases {
                let viewModel = WeatherViewModel(page: page, cityWeathers: .init($0))
                let weatherViewController = WeatherViewController(viewModel: viewModel)
                
                self.contentsViewControllers.append(weatherViewController)
            }
            
            if let firstViewController = self.contentsViewControllers.first {
                self.pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
            }
        }
    }
        
    private func setupAttributes() {
        pageViewController.dataSource = self
    }
    
    private func setupViews() {
        view.addSubview(pageViewController.view)
        self.addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: PageViewController Datasource
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contentsViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return contentsViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contentsViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        if nextIndex == contentsViewControllers.count {
            return nil
        }
        
        return contentsViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return Page.allCases.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return .zero
    }
}

