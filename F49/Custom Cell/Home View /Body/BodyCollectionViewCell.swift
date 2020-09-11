//
//  BodyCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 9/10/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class BodyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailTitleLabel: UILabel!
    @IBOutlet weak var thumbnailCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayUI(){
        thumbnailImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        thumbnailImageView.layer.shadowRadius = 1
    }
}
