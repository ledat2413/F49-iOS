//
//  KhachHangHopDongTheChapTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/19/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class KhachHangHopDongTheChapTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cmndLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var queQuanLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
