//
//  UtilitiesBodyCollectionViewCell.swift
//  F49
//
//  Created by Le Dat on 9/16/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UtilitiesBodyCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayUI()
        
    }
    
    func displayUI(){
        shadowView(countView)
        cornerRadius(countLabel)

    }
    
    func ui(model: TienIch){
        if model.giaTri.isEmpty {
            self.countView.isHidden = true
        }
        let upCase = model.tieuDe.uppercased()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.titleLabel.text = upCase
        self.imageView.sd_setImage(with: URL(string: model.hinhAnh), placeholderImage: UIImage(named: "heart"))
        self.countLabel.text = model.giaTri
        self.imageView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
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
