//
//  InfoCamDoTableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class InfoCamDoTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}