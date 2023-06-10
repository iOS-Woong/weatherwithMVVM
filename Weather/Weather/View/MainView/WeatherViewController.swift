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
        let mockAnyHashables = viewModel.testUUIDs() // 테스트객체 (제거할것)
        snapshot?.appendSections([.hourly])
        snapshot?.appendItems(mockAnyHashables)
        datasource?.apply(self.snapshot!, animatingDifferences: true)
    }
    
    private func setupCollectionViewAttributes() {
        weatherCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
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
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .absolute(110)),
                                                               subitems: [item])
                
                let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                               heightDimension: .fractionalHeight(0.25)),
                                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                                             alignment: .top)
                section?.boundarySupplementaryItems = [headerView]
                
                section = .init(group: group)
                section?.orthogonalScrollingBehavior = .continuous
                
                return section
            
            case .city:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(500)),
                                                             subitems: [item])
                section = .init(group: group)
                
                return section
                
            case .wind:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                    heightDimension: .fractionalHeight(1.0)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(250)),
                                                             subitems: [item])
                section = .init(group: group)

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
        
        datasource = Datasource(collectionView: weatherCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return self.weatherCollectionView.dequeueConfiguredReusableCell(using: hourlyCollectionViewCellResistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    private func configureSupplementaryViewDatasource() {
        let hourlyHeaderViewResistration = hourlySectionHeaderConfigure()
        
        datasource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            var collectionReusableView: UICollectionReusableView?
            // TODO: 섹션별로 헤더를 다르게 설정해줄 것
            collectionReusableView = collectionView.dequeueConfiguredReusableSupplementary(using: hourlyHeaderViewResistration, for: indexPath)

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
}
