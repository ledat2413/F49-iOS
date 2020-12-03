//
//  ButtonFooterCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 10/1/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ButtonFooterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ui(color: UIColor, textString: String){
        self.thumbnailLabel.backgroundColor = color
        self.thumbnailLabel.text = textString
        self.thumbnailLabel.displayCornerRadius(radius: 20)
    }
}
