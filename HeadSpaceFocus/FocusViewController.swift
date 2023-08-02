//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 최지연/클라이언트 on 2023/08/01.
//

import UIKit

class FocusViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Focus>!
    
    var list: [Focus] = Focus.recommendations
    var isAll = false
    
    // Data, Presentation, Layout
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Focus>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        refreshButton.layer.cornerRadius = 10
        refreshList()
        
        // layer
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func refreshList() {
        isAll = !isAll
        list = isAll ? Focus.list : Focus.recommendations
        let buttonText = isAll ? "See Recommendation" : "See All"
        refreshButton.setTitle(buttonText, for: .normal)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Focus>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        refreshList()
    }
}

extension FocusViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "QuickFocus", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "QuickFocusListViewController") as? QuickFocusListViewController else { return }
        let focus = list[indexPath.item]
        print(">>> selected \(focus.title)")
        vc.title = focus.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
