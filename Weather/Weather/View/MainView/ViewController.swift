//
//  ViewController.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {

    private let contentsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .vertical
        collectionView.register(ContentsCollectionViewCell.self,
                                        forCellWithReuseIdentifier: ContentsCollectionViewCell.reuseIdentifier)
        collectionView.register(ContentCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ContentCollectionHeaderView.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        setupViews()
    }

    private func setupAttributes() {
        contentsCollectionView.dataSource = self
        contentsCollectionView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(contentsCollectionView)
        
        NSLayoutConstraint.activate([
            contentsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            contentsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.reuseIdentifier, for: indexPath) as! ContentsCollectionViewCell
        
        cell.configure(text: "\(indexPath.item)")
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
                  let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: ContentCollectionHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? ContentCollectionHeaderView else {return UICollectionReusableView()}
        header.configure()
            return header
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.05)
    }
}
