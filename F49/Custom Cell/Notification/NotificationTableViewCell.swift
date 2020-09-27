//
//  NotificationTableViewCell.swift
//  F49
//
//  Created by Le Dat on 9/26/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
