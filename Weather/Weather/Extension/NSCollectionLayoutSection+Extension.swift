//
//  NSCollectionLayoutSection+Extension.swift
//  Weather
//
//  Created by 서현웅 on 2023/07/03.
//

import UIKit

extension NSCollectionLayoutSection {
    static func continuousFiveColumnsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.2),
                                                            heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(110)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [commonSectionHeaderView()]
        section.decorationItems = [commonDecorateItemView()]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    static func listSection(heightDimension: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: heightDimension),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [commonSectionHeaderView()]
        section.decorationItems = [commonDecorateItemView()]
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    static func gridSection() -> NSCollectionLayoutSection {
        let headerView = gridSectionItemHeaderView()
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                            heightDimension: .fractionalHeight(1.0)),
                                          supplementaryItems: [headerView])
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(220)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
    private static func commonSectionHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(0.04)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        sectionHeaderView.pinToVisibleBounds = true
        
        return sectionHeaderView
    }
    
    private static func gridSectionItemHeaderView() -> NSCollectionLayoutSupplementaryItem {
        let itemHeaderView = NSCollectionLayoutSupplementaryItem.init(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(30)),
            elementKind: "detailSection-itemHeader",
            containerAnchor: .init(edges: .top)
        )
        
        return itemHeaderView
    }
    
    private static func commonDecorateItemView() -> NSCollectionLayoutDecorationItem {
        let decorateItem = NSCollectionLayoutDecorationItem.background(
            elementKind: CommonCollectionBackgroundView.reuseIdentifier
        )
        decorateItem.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        return decorateItem
    }
    
}
