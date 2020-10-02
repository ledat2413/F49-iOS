//
//  PickerView.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

class PickerView: UIView, UIPickerViewDelegate,UITextFieldDelegate{

    func createPickerView(_ view: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        view.inputView = pickerView
    }
    
//    func dismissPickerView(_ view: UITextField) {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(self.action))
//        toolBar.setItems([button], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        view.inputAccessoryView = toolBar
//    }
    
    @objc func action() {
        self.endEditing(true)
    }
    
    
    
}
