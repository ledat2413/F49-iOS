//
//  ContractOpenTableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ContractOpenTableViewCell: UITableViewCell {

    //MARK: --IBOutlet
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var id2Label: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tangGiamLabel: UILabel!
    @IBOutlet weak var tienLabel: UILabel!
    @IBOutlet weak var tongLabel: UILabel!
    
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var title3Label: UILabel!
    
    @IBOutlet weak var icon1ImageView: UIImageView!
    @IBOutlet weak var icon2ImageView: UIImageView!
    @IBOutlet weak var icon3Imageview: UIImageView!
    
    @IBOutlet weak var betweenLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
