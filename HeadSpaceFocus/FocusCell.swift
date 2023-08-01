//
//  FocusCell.swift
//  HeadSpaceFocus
//
//  Created by 최지연/클라이언트 on 2023/08/01.
//

import UIKit

class FocusCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.systemIndigo
        contentView.layer.cornerRadius = 10
    }
    
    func configure(_ focus: Focus) {
        titleLabel.text = focus.title
        descriptionLabel.text = focus.description
        thumbnailImageView.image = UIImage(systemName: focus.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
