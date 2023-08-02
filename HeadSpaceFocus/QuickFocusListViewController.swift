//
//  QuickFocusListViewController.swift
//  HeadSpaceFocus
//
//  Created by 최지연/클라이언트 on 2023/08/02.
//

import UIKit

class QuickFocusListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking
    
    enum Section: CaseIterable {
        case breathing
        case walking
        
        var title: String {
            switch self {
            case .breathing: return "Breathing exercises"
            case .walking: return "Mindful walks"
            }
        }
    }
    
    typealias Item = QuickFocus
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else { return nil }
            cell.configure(itemIdentifier)
            return cell
        })
        
        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else { return nil }
            
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
//            header.titleLabel.text = allSections[indexPath.section].title
            return header
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathing, .walking])
        snapshot.appendItems(breathingList, toSection: .breathing)
        snapshot.appendItems(walkingList, toSection: .walking)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        self.navigationItem.largeTitleDisplayMode = .never // 라지타이틀 모드 제거
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)) // 높이 estimated 넣어주면 텍스트 길어질 시에 자동으로 높이 늘어남.
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10) // 그룹 안에 아이템 끼리 간격
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20) // 섹션 마진
        section.interGroupSpacing = 20 // 섹션 안에 그룹 간 간격
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
