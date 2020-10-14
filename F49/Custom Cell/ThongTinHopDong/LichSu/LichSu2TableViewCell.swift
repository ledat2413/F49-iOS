//
//  LichSu2TableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class LichSu2TableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var choVayLabel: UILabel!
    @IBOutlet weak var noGocLabel: UILabel!
    @IBOutlet weak var nhanVienLabel: UILabel!
    
    @IBOutlet weak var choVayTitleLabel: UILabel!
    @IBOutlet weak var noGocTitleLabel: UILabel!
    @IBOutlet weak var nhanVienTitleLabel: UILabel!
    @IBOutlet weak var nhanVienImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
