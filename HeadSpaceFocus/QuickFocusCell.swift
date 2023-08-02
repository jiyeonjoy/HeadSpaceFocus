//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 최지연/클라이언트 on 2023/08/02.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ quickFocus: QuickFocus) {
        thumbnailImageView.image = UIImage(named: quickFocus.imageName)
        
        titleLabel.text = quickFocus.title
        descriptionLabel.text = quickFocus.description
    }
}
