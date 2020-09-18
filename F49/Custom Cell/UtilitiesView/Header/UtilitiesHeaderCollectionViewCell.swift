//
//  UtilitiesHeaderCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 9/16/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UtilitiesHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
