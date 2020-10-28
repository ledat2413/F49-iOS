//
//  Cell6CreateTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class Cell6CreateTableViewCell: UITableViewCell {

    
     var enableKeyboard: Bool = true
     var idCell: Int?
     var callBackOpenView: (() -> Void)?
     var callBackValue:  ((_ value: String) -> Void)?
    
    @IBOutlet weak var thumbnail1TextField: UITextField!
    
    @IBOutlet weak var thumbnail2TextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        thumbnail1TextField.delegate = self
        thumbnail2TextField.delegate = self
        // Configure the view for the selected state
    }
    
}

extension Cell6CreateTableViewCell: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let callBackOpenView = self.callBackOpenView {
            callBackOpenView()
        }
        return enableKeyboard
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.callBackValue?(textField.text!)
    }
}
