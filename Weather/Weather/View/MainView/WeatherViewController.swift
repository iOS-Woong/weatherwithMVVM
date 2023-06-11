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
    
    private let viewModel: MainViewModel
    
    private var datasource: Datasource?
    private var snapshot: Snapshot?
    
    private let weatherCollectionView = {
        let collectioniView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        collectioniView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectioniView
    }()
    
    init(viewModel: MainViewModel) {
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
        configureSnapshot()
    }
    
    private func configureSnapshot() {
        snapshot = .init()
        let hourlyMockAnyHashables = viewModel.testUUIDs(count: 24) // 테스트객체 (제거할것)
        let cityMockAnyHashables = viewModel.testUUIDs(count: QueryItem.allCases.count - 1) // 서울뺴고
        let windMockAnyHashables = viewModel.testUUIDs(count: 1)
        
        snapshot?.appendSections([.hourly, .city, .wind])
        snapshot?.appendItems(hourlyMockAnyHashables, toSection: .hourly)
        snapshot?.appendItems(cityMockAnyHashables, toSection: .city)
        snapshot?.appendItems(windMockAnyHashables, toSection: .wind)
        datasource?.apply(self.snapshot!, animatingDifferences: true)
    }
    
    private func setupCollectionViewAttributes() {
        weatherCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViews() {
        let collectionImage = UIImage(named: "night")
        weatherCollectionView.backgroundView = UIImageView(image: collectionImage)
        view.addSubview(weatherCollectionView)
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
                group.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
                
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.4)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                section = .init(group: group)
                section?.boundarySupplementaryItems = [headerView]
                
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
                                                                               heightDimension: .absolute(400)),
                                                             subitems: [item])
                section = .init(group: group)

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
        return layout
    }
}

// MARK: DiffableDataSource Configure
extension WeatherViewController {
    private func configureCollectionViewCellDatasource() {
        let hourlyCollectionViewCellResistration = hourlySecitonItemConfigure()
        let cityCollectionViewCellResistration = citySectionItemConfigure()
        let windCollectionViewCellResistration = windSectionItemConfigure()
        
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
                return nil
            case .detail:
                return nil
            }
        })
    }
    
    private func configureSupplementaryViewDatasource() {
        let hourlyHeaderViewResistration = hourlySectionHeaderConfigure()
        let cityHeaderViewResistration = citySectionHeaderConfigure()
        
        datasource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            var collectionReusableView: UICollectionReusableView?
            
            switch sectionKind {
            case .hourly:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: hourlyHeaderViewResistration, for: indexPath)
            case .city:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .wind:
                collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: cityHeaderViewResistration, for: indexPath)
            case .tempMap:
                print("A")
            case .detail:
                print("A")
            }
            
            return collectionReusableView
        }
    }
    
    private func hourlySecitonItemConfigure() -> UICollectionView.CellRegistration<HourlyCollectionViewCell, Any> {
        let hourlySectionResistration = UICollectionView.CellRegistration<HourlyCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            // TODO: 여기에 hourlyCell 컨피규어
        }
        
        return hourlySectionResistration
    }
    
    private func hourlySectionHeaderConfigure() -> UICollectionView.SupplementaryRegistration<hourlyCollectionHeaderView> {
        let hourlySectionHeaderResistration = UICollectionView.SupplementaryRegistration<hourlyCollectionHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            // TODO: 여기 hourlyHeader 컨피규어
        }
        
        return hourlySectionHeaderResistration
    }
    
    private func citySectionItemConfigure() -> UICollectionView.CellRegistration<CityCollectionViewCell, Any> {
        let citySectionResistration = UICollectionView.CellRegistration<CityCollectionViewCell, Any> { cell, indexPath, itemIdentifier in
            // TODO: 여기 cityCell 컨피규어
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
}
