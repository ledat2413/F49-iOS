//
//  ExtensionUIDatePicker.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker{
    
    func dateFormatte(txt: UITextField){
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        txt.text = formatter.string(from: self.date)
    }
    
    func formatter1(picker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.string(from: picker.date)
    }
    
    func createDatePicker(tf: UITextField) -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        tf.inputView = datePicker
        return datePicker
    }
}
