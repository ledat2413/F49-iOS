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
        thumbnailCountView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 6)
        thumbnailCountLabel.displayCornerRadius(radius: 6)
        thumbnailCornerRadiusView.displayCornerRadius(radius: 6)

    }
    
    func ui(model: DashBoard){
        let newStr = model.tieuDe.uppercased()
        self.thumbnailTitleLabel.text = newStr
        self.thumbnailCountLabel.text = model.giaTri
        self.thumbnailImageView.sd_setImage(with: URL(string: model.hinhAnh), placeholderImage: UIImage(named: "heart"))
        
        self.displayShadowView(shadowColor: UIColor.gray, borderColor: UIColor.clear, radius: 15)
        self.thumbnailImageView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }

}
