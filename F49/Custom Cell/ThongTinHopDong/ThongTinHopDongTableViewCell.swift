//
//  ThongTinHopDongTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinHopDongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumnailImageView: UIImageView!
    
    @IBOutlet weak var thumbnailTitleLabel: UILabel!
    
    @IBOutlet weak var thumbnailNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
