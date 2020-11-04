//
//  RutVonTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/1/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class RutVonTableViewCell: UITableViewCell {

    @IBOutlet weak var header1Label: UILabel!
    @IBOutlet weak var header2Label: UILabel!
    @IBOutlet weak var header3Label: UILabel!
    @IBOutlet weak var header2ImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
