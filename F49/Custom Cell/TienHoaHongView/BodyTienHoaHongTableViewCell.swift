//
//  BodyTienHoaHongTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class BodyTienHoaHongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sttLabel: UILabel!
    @IBOutlet weak var idHopDongLabel: UILabel!
    @IBOutlet weak var khachHangLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var noDataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
