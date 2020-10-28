//
//  Cell4CreateTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class Cell4CreateTableViewCell: UITableViewCell {
    
    var callBackValue: ((_ value: Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func valueButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        callBackValue?(sender.isSelected)
    }
}
