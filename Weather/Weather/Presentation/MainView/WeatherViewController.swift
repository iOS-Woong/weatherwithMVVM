//
//  ViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

enum Section: Int {
    case hourly, city, wind, tempMap, detail
}

class WeatherViewController: UIViewController {
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private let viewModel: WeatherViewModel
    private var datasource: Datasource?
    private var snapshot: Snapshot?
    
    private let weatherCollectionView = {
        let collectioniView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectioniView.translatesAutoresizingMaskIntoConstraints = false
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
            self.configureLastSnapshot([self.viewModel.cityWeatherCurrentPage], to: .wind)
            self.configureLastSnapshot([UUID()], to: .tempMap)
            self.configureLastSnapshot([UUID(),UUID(),UUID(),UUID(),UUID(),UUID()], to: .detail)
        })
    }
    
    private func fetch() {
        viewModel.fetchWeatherData()
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
        weatherCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViews() {
        // TODO: 수정
        let viewImage = UIImage(named: "night")
        view.backgroundColor = UIColor(patternImage: viewImage!)
        weatherCollectionView.backgroundColor = .clear
        
        view.addSubview(weatherCollectionView)
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            weatherCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
                
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.07)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                headerView.pinToVisibleBounds = true
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                let decorateItem = NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                section?.decorationItems = [decorateItem]
                
                section?.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .city:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(60)),
                                                             subitems: [item])
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.07)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                headerView.pinToVisibleBounds = true
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                let decorateItem = NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                section?.decorationItems = [decorateItem]
                
                return section
                
            case .wind:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(150)),
                                                             subitems: [item])
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.07)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                headerView.pinToVisibleBounds = true
                section = .init(group: group)
                
                section?.boundarySupplementaryItems = [headerView]
                
                let decorateItem = NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                section?.decorationItems = [decorateItem]

                return section
                
            case .tempMap:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(300)),
                                                             subitems: [item])
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.07)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                headerView.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                headerView.pinToVisibleBounds = true
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                
                let decorateItem = NSCollectionLayoutDecorationItem.background(elementKind: CommonCollectionBackgroundView.reuseIdentifier)
                section?.decorationItems = [decorateItem]
                
                return section
                
            case .detail:
                let headerView = NSCollectionLayoutSupplementaryItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                            heightDimension: .absolute(30)),
                                                                          elementKind: "detailSection-itemHeader",
                                                                          containerAnchor: .init(edges: .top))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                    heightDimension: .fractionalHeight(1.0)),
                                                  supplementaryItems: [headerView])
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .absolute(220)),
                                                               subitems: [item])
                section = .init(group: group)
                
                return section
            }
            
        }
        layout.register(CommonCollectionBackgroundView.self, forDecorationViewOfKind: CommonCollectionBackgroundView.reuseIdentifier)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 15
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .absolute(380)),
                                                                     elementKind: "layout-header-element-kind",
                                                                     alignment: .top)
        
        config.boundarySupplementaryItems = [headerView]
        layout.configuration = config
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
        let detailCollectionViewCellResistration = detailSectionItemConfigure()
        
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
                return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailCollectionViewCellResistration,
                                                                                for: indexPath, item: itemIdentifier)
            }
        })
    }
    
    private func configureSupplementaryViewDatasource() {
        let commonTitleHeaderResistration = commonTitleHeaderConfigure()
        let commonSectionHeaderViewResistration = commonSectionHeaderConfigure(of: UICollectionView.elementKindSectionHeader)
        let itemHeaderViewResistration = commonSectionHeaderConfigure(of: "detailSection-itemHeader")
        
        datasource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            var collectionReusableView: UICollectionReusableView?
            
            switch elementKind {
            case "layout-header-element-kind":
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: commonTitleHeaderResistration,
                                                                                               for: indexPath)
            case "detailSection-itemHeader":
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: itemHeaderViewResistration,
                                                                                               for: indexPath)
            default:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: commonSectionHeaderViewResistration,
                                                                                               for: indexPath)
            }
            
            
            return collectionReusableView
        }
    }
    
    private func commonTitleHeaderConfigure() -> UICollectionView.SupplementaryRegistration<CommonTitleHeaderView> {
        let commonSectionHeaderResistration = UICollectionView.SupplementaryRegistration<CommonTitleHeaderView>(
            elementKind: "layout-header-element-kind") { supplementaryView, elementKind, indexPath in
                guard let cityWeatherCurrentPage = self.viewModel.cityWeatherCurrentPage else { return }
                supplementaryView.configure(data: cityWeatherCurrentPage)
        }
        
        return commonSectionHeaderResistration
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
    
    private func commonSectionHeaderConfigure(of elementKind: String) -> UICollectionView.SupplementaryRegistration<CommonCollectionSectionHeaderView> {
        let citySectionHeaderResistration = UICollectionView.SupplementaryRegistration<CommonCollectionSectionHeaderView>(
            elementKind: elementKind) { supplementaryView, elementKind, indexPath in
                guard let sectionKind = Section(rawValue: indexPath.section) else { return }
                supplementaryView.configureHeader(section: sectionKind,
                                                  item: indexPath.item)
            }
        
        return citySectionHeaderResistration
    }
    
    private func windSectionItemConfigure() -> UICollectionView.CellRegistration<WindCollectionViewCell, Any> {
        let windSectionResistration = UICollectionView.CellRegistration<WindCollectionViewCell,Any> { cell, indexPath, itemIdentifier in
            guard let itemIdentifier = itemIdentifier as? CityWeather else { return }
            cell.configure(data: itemIdentifier)
        }
        return windSectionResistration
    }
    
    private func tempSectionItemConfigure() -> UICollectionView.CellRegistration<TempMapCollectionViewCell, Any> {
        let tempSectionResistration = UICollectionView.CellRegistration<TempMapCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            self.viewModel.fetchTempMap {
                cell.configure(data: $0)
            }
        }
        
        return tempSectionResistration
    }
    
    private func detailSectionItemConfigure() -> UICollectionView.CellRegistration<DetailTwoLabelStyleCollectionViewCell, Any> {
        let detailSectionResistration = UICollectionView.CellRegistration<DetailTwoLabelStyleCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            guard let itemIdentifier = itemIdentifier as? CityWeather else { return }
            cell.configure(data: itemIdentifier)
        }
        
        return detailSectionResistration
    }
}
