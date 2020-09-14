//
//  BodyCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 9/10/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class BodyCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var thumbnailCornerRadiusView: UIView!
    @IBOutlet weak var thumbnailCountView: UIView!
    @IBOutlet weak var thumbnailTitleLabel: UILabel!
    @IBOutlet weak var thumbnailCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayUI()
        
    }
    
    func displayUI(){
        shadowView(thumbnailCountView)
        cornerRadius(thumbnailCountLabel)
        cornerRadius(thumbnailCornerRadiusView)
    }
    
    func shadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.9
        view.layer.cornerRadius = 6
    }
    
    func cornerRadius(_ view: UIView){
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
    }

}
