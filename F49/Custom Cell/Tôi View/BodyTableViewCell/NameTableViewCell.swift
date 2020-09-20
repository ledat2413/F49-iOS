//
//  NameTableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailValue: UILabel!
    @IBOutlet weak var thumbnailKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
