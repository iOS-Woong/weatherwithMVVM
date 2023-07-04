//
//  ViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

enum Section: Int, CaseIterable {
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
        viewModel.forecasts.subscribe(onNext: {
            self.configureLastSnapshot($0)
        })
    }
    
    private func fetch() {
        viewModel.fetchWeatherData()
    }
    
    private func configureLastSnapshot(_ itemIdentifier: [AnyHashable]?) {
        DispatchQueue.main.async {
            if self.snapshot == nil {
                self.snapshot = .init()
            }
            guard let itemIdentifier else { return }
            
            self.snapshot?.appendSections(Section.allCases)
            
            self.snapshot?.appendItems(itemIdentifier, toSection: .hourly)
            self.snapshot?.appendItems(self.viewModel.cityWeathersExcludingCurrentPage, toSection: .city)
            self.snapshot?.appendItems([self.viewModel.cityWeatherCurrentPage], toSection: .wind)
            self.snapshot?.appendItems([UUID()], toSection: .tempMap)
            self.snapshot?.appendItems([UUID(),UUID(),UUID(),UUID(),UUID(),UUID()], toSection: .detail) // 임시
            
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
            
            switch sectionKind {
            case .hourly:
                return NSCollectionLayoutSection.continuousFiveColumnsSection()
            case .city:
                return NSCollectionLayoutSection.listSection(heightDimension: .absolute(60))
            case .wind:
                return NSCollectionLayoutSection.listSection(heightDimension: .absolute(150))
            case .tempMap:
                return NSCollectionLayoutSection.listSection(heightDimension: .absolute(300))
            case .detail:
                return NSCollectionLayoutSection.gridSection()
            }
        }
        
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(380)),
            elementKind: "layout-header-element-kind",
            alignment: .top
        )
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        config.interSectionSpacing = 15
        config.boundarySupplementaryItems = [headerView]
        layout.configuration = config
        layout.register(CommonCollectionBackgroundView.self,
                        forDecorationViewOfKind: CommonCollectionBackgroundView.reuseIdentifier)
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
        
        // detail
        let detailCollectionViewCellResistration = detailSectionTwoLabelStyleItemConfigure()
        let detailSensoryCellResistration = detailSectionSensoryGraphStyleItemConfigure()
        
        datasource = Datasource(collectionView: weatherCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }

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
                guard let itemKind = DetailItem(rawValue: indexPath.item) else { return nil }
                switch itemKind {
                case .sensory:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailSensoryCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                case .humidity:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailCollectionViewCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                case .visiblity:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailCollectionViewCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                case .sun:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailSensoryCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                case .cloud:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailCollectionViewCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                case .pressure:
                    return self.weatherCollectionView.dequeueConfiguredReusableCell(using: detailSensoryCellResistration,
                                                                                    for: indexPath, item: itemIdentifier)
                }
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
    
    // DetailSectionItem, MultiCellConfiguration
    
    private func detailSectionTwoLabelStyleItemConfigure() -> UICollectionView.CellRegistration<DetailTwoLabelStyleCollectionViewCell, Any> {
        let detailSectionTwoLabelStyleResistration = UICollectionView.CellRegistration<DetailTwoLabelStyleCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            guard let detailItemKind = DetailItem(rawValue: indexPath.row) else { return }
            guard let itemIdentifier = self.viewModel.cityWeatherCurrentPage else { return }
            cell.configure(data: itemIdentifier, detailItemKind: detailItemKind)
        }
        
        return detailSectionTwoLabelStyleResistration
    }
    
    private func detailSectionSensoryGraphStyleItemConfigure() -> UICollectionView.CellRegistration<DetailSensoryGraphCollectionViewCell, Any> {
        let detailSectionSensoryGraphStyleResistration = UICollectionView.CellRegistration<DetailSensoryGraphCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            guard let itemIdentifier = self.viewModel.cityWeatherCurrentPage else { return }
            cell.configure(data: itemIdentifier)
        }
        
        return detailSectionSensoryGraphStyleResistration
    }
    
}
