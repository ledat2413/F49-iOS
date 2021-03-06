//
//  ThuLai3TableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThuLai3TableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var iconDownButton: UIButton!
    @IBOutlet weak var iconLichButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ui(keyString: String, valueString: String, isHiddenTextField: Bool, isHiddenDownButton: Bool, isHiddenLichButton: Bool, numberPad: Bool){
        self.keyLabel.text = keyString
        self.valueLabel.text = valueString
        self.valueTextField.isHidden = isHiddenTextField
        if numberPad == true {
            self.valueTextField.keyboardType = .numberPad
        }
        self.iconDownButton.isHidden = isHiddenDownButton
        self.iconLichButton.isHidden = isHiddenLichButton
    }
    
}
