//
//  ViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

class WeatherViewController: UIViewController {
    enum Section: Int {
        case hourly, city, wind, tempMap, detail
    }
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private let viewModel: WeatherViewModel
    private var datasource: Datasource?
    private var snapshot: Snapshot?
    
    private let scrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentsVerticalStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let commonTitleView = {
        let view = CommonTitleView()
        return view
    }()
    
    private let weatherCollectionView = {
        let collectioniView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectioniView
    }()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionViewAttributes()
        configureCollectionViewCellDatasource()
        configureSupplementaryViewDatasource()
        configureCommonTitleView()
        bind()
        fetch()
    }
    
    private func bind() {
        viewModel.forecasts.subscribe(onNext: { forecasts in
            guard let forecasts else { return }
            self.configureLastSnapshot(forecasts,
                                       to: .hourly)
            self.configureLastSnapshot(self.viewModel.cityWeathersExcludingCurrentPage,
                                       to: .city)
        })
    }
    
    private func fetch() {
        viewModel.fetchWeatherData()
    }
    
    private func configureCommonTitleView() {
        guard let pageCityWeather = viewModel.cityWeathers.filter({
            $0.name == viewModel.page.capitalizedPage
        }).first else { return }
        
        commonTitleView.configure(data: pageCityWeather)
    }
    
    
    private func configureLastSnapshot(_ itemIdentifier: [AnyHashable], to section: Section) {
        DispatchQueue.main.async {
            if self.snapshot == nil {
                self.snapshot = .init()
            }
            self.snapshot?.appendSections([section])
            self.snapshot?.appendItems(itemIdentifier, toSection: section)
            self.datasource?.apply(self.snapshot!, animatingDifferences: true)
        }
    }
    
    private func setupCollectionViewAttributes() {
        weatherCollectionView.isScrollEnabled = false
        weatherCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViews() {
        // TODO: 수정
        let viewImage = UIImage(named: "night")
        view.backgroundColor = UIColor(patternImage: viewImage!)
        weatherCollectionView.backgroundColor = .clear
        
        [commonTitleView, weatherCollectionView].forEach(contentsVerticalStackView.addArrangedSubview(_:))
        scrollView.addSubview(contentsVerticalStackView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentsVerticalStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentsVerticalStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentsVerticalStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentsVerticalStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentsVerticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            commonTitleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            weatherCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])
    }
}

// MARK: Layout Configure
extension WeatherViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionNumber) else { return nil }
            var section: NSCollectionLayoutSection?
            
            switch sectionKind {
            case .hourly:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.2),
                                                                    heightDimension: .fractionalHeight(1.0)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .absolute(150)),
                                                               subitems: [item])
                group.contentInsets = .init(top: 10, leading: 10, bottom: 30, trailing: 10)
                
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.08)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                section?.decorationItems = [
                    NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                ]
                
                section?.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .city:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(60)),
                                                             subitems: [item])
                group.contentInsets = .init(top: 10, leading: 10, bottom: 5, trailing: 10)
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.05)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                section?.decorationItems = [
                    NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                ]
                
                return section
                
            case .wind:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(150)),
                                                             subitems: [item])
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.05)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section = .init(group: group)
                
                section?.boundarySupplementaryItems = [headerView]
                section?.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
                
            case .tempMap:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(300)),
                                                             subitems: [item])
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.05)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                section?.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                
                return section
                
            case .detail:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(300)),
                                                             subitems: [item])
                section = .init(group: group)
                
                
                return section
            }
            
        }
        layout.register(CommonCollectionBackgroundView.self, forDecorationViewOfKind: CommonCollectionBackgroundView.reuseIdentifier)
        
        return layout
    }
}

// MARK: DiffableDataSource Configure
extension WeatherViewController {
    private func configureCollectionViewCellDatasource() {
        let hourlyCollectionViewCellResistration = hourlySecitonItemConfigure()
        let cityCollectionViewCellResistration = citySectionItemConfigure()
        let windCollectionViewCellResistration = windSectionItemConfigure()
        let tempMapCollectionViewCellResistration = tempSectionItemConfigure()
        
        datasource = Datasource(collectionView: weatherCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            // TODO: 공통으로 들어가는 섹션구성
            switch sectionKind {
            case .hourly:
                return self.weatherCollectionView.dequeueConfiguredReusableCell(using: hourlyCollectionViewCellResistration,
                                                                                for: indexPath, item: itemIdentifier)
            case .city:
                return self.weatherCollectionView.dequeueConfiguredReusableCell(using: cityCollectionViewCellResistration,
                                                                                for: indexPath, item: itemIdentifier)
            case .wind:
                return self.weatherCollectionView.dequeueConfiguredReusableCell(using: windCollectionViewCellResistration,
                                                                                for: indexPath, item: itemIdentifier)
            case .tempMap:
                return self.weatherCollectionView.dequeueConfiguredReusableCell(using: tempMapCollectionViewCellResistration,
                                                                                for: indexPath, item: itemIdentifier)
            case .detail:
                return nil
            }
        })
    }
    
    private func configureSupplementaryViewDatasource() {
        let cityHeaderViewResistration = citySectionHeaderConfigure()
        
        datasource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            var collectionReusableView: UICollectionReusableView?
            
            switch sectionKind {
            case .hourly:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .city:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .wind:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .tempMap:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .detail:
                print("A")
            }
            
            return collectionReusableView
        }
    }
    
    private func hourlySecitonItemConfigure() -> UICollectionView.CellRegistration<HourlyCollectionViewCell, Any> {
        let hourlySectionResistration = UICollectionView.CellRegistration<HourlyCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            guard let itemIdentifier = itemIdentifier as? Forecast else { return }
            cell.configure(text: itemIdentifier)
            
            self.viewModel.fetchWeatherIcon(iconString: itemIdentifier.icon) {
                cell.configure(image: $0)
            }
        }
        
        return hourlySectionResistration
    }
    
    private func citySectionItemConfigure() -> UICollectionView.CellRegistration<CityCollectionViewCell, Any> {
        let citySectionResistration = UICollectionView.CellRegistration<CityCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            guard let itemIdentifier = itemIdentifier as? CityWeather else { return }
            cell.configure(itemIdentifier)
            self.viewModel.fetchWeatherIcon(iconString: itemIdentifier.icon) {
                cell.configure($0) }
        }
        return citySectionResistration
    }
    
    private func citySectionHeaderConfigure() -> UICollectionView.SupplementaryRegistration<CityCollectionHeaderView> {
        let citySectionHeaderResistration = UICollectionView.SupplementaryRegistration<CityCollectionHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
                // TODO: 여기 cityHeader 컨피규어
            }
        
        return citySectionHeaderResistration
    }
    
    private func windSectionItemConfigure() -> UICollectionView.CellRegistration<WindCollectionViewCell, Any> {
        let windSectionResistration = UICollectionView.CellRegistration<WindCollectionViewCell,Any> { cell, indexPath, itemIdentifier in
            // TODO: 여기 windCell 컨피규어
        }
        return windSectionResistration
    }
    
    private func tempSectionItemConfigure() -> UICollectionView.CellRegistration<TempMapCollectionViewCell, Any> {
        let tempSectionResistration = UICollectionView.CellRegistration<TempMapCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            // TODO: 여기 tempCell 컨피규어
        }
        
        return tempSectionResistration
    }
    
    private func detailSectionItemConfigure() -> UICollectionView.CellRegistration<DetailCollectionViewCell, Any> {
        let detailSectionResistration = UICollectionView.CellRegistration<DetailCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            // TODO: detailSection의 복잡도로 인해 컨피규어는 추후 서버통신작업을 마치고 진행함
        }
        return detailSectionResistration
    }
    
}
