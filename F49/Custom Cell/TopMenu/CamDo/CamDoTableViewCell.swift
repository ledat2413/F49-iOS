//
//  CamDoTableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CamDoTableViewCell: UITableViewCell {

    
    //MARK: --IBOutlet
    
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberPhoneLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
