//
//  Cell2CreateTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class Cell2CreateTableViewCell: UITableViewCell{
    
    var enableKeyboard: Bool = true
    var idCell: Int?
    var callBackOpenView: (() -> Void)?
    var callBackValue:  ((_ value: String) -> Void)?
    
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var thumbnailtextField: UITextField!
    
    @IBOutlet weak var celendarButton: UIButton!
    
    @IBOutlet weak var downButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailtextField.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension Cell2CreateTableViewCell: UITextFieldDelegate{
    
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
