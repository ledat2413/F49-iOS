//
//  ExtensionPickerView.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

extension UIPickerView {
    func createPicker(tf: UITextField) -> UIPickerView {
        let pickerView = UIPickerView()
        tf.inputView = pickerView
        
        return pickerView
    }
}
