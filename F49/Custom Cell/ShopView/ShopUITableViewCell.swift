//
//  ShopUITableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/16/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ShopUITableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var nameShopLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func radioButtonPressed(_ sender: Any) {
        
    }
}
