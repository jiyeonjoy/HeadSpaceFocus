//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 최지연/클라이언트 on 2023/08/02.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
