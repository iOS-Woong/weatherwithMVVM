//
//  PagingCollectionViewCell.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/25.
//

import UIKit

class PagingCollectionViewCell: UICollectionViewCell, ReusableView {
    enum Section: Int {
        case hourly, city, wind, tempMap, detail
    }
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    var weather: Weather?
    var forecast: [Forecast]?
    
    private let weatherCollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCollectionViewAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViewAttributes() {
        weatherCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setupViews() {
        contentView.addSubview(weatherCollectionView)
        
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weatherCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Configure CompositionalLayout
extension PagingCollectionViewCell {
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

        return layout
    }
    
}
