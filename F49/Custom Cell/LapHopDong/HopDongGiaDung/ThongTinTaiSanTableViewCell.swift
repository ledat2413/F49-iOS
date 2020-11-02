//
//  ThongTinTaiSanTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinTaiSanTableViewCell: UITableViewCell {

    var buttonPressed: (() -> Void)?
    @IBOutlet weak var thuTuLabel: UILabel!
    @IBOutlet weak var tenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func chitietButtonPressed(_ sender: Any) {
        self.buttonPressed?()
    }
    
}
