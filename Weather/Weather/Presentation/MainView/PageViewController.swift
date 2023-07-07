//
//  PageViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/26.
//

import UIKit

protocol BackgroundViewUpdateDelegate {
    func updateBackgroundView(weatherId: Int)
}

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
                weatherViewController.delegate = self
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

// MARK: BackgroundViewUpdateDelegate 관련
extension PageViewController: BackgroundViewUpdateDelegate {
    func updateBackgroundView(weatherId: Int) {
        guard let weather: WeatherCase = branchWeatherCase(weatherId: weatherId),
              let weatherImage = weather.imageDescription else { return }
        
        view.backgroundColor = UIColor(patternImage: weatherImage)
    }
    
    private func branchWeatherCase(weatherId: Int) -> WeatherCase? {
        switch weatherId {
        case 200...299:
            return .thunder
        case 300...599:
            return .rainy
        case 600...699:
            return .snow
        default:
            guard let classfiedWeatherCase = classifyCurrentTime() else { return nil }
            
            return classfiedWeatherCase
        }
    }
    
    private func classifyCurrentTime() -> WeatherCase? {
        let currentDate = Date()
        let calendar = Calendar.current

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        guard let morningStartTime = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: currentDate),
              let morningEndTime = calendar.date(bySettingHour: 17, minute: 59, second: 59, of: currentDate) else { return nil }

        if currentDate >= morningStartTime && currentDate <= morningEndTime {
            return .clearMorning
        } else {
            return .clearNight
        }
    }
}

private enum WeatherCase {
    case thunder, rainy, snow, clearMorning, clearNight
    
    var imageDescription: UIImage? {
        switch self {
        case .thunder:
            return UIImage(named: "thunder")
        case .rainy:
            return UIImage(named: "rainy")
        case .snow:
            return UIImage(named: "snow")
        case .clearMorning:
            return UIImage(named: "clearMorning")
        case .clearNight:
            return UIImage(named: "clearNight")
        }
    }
}
