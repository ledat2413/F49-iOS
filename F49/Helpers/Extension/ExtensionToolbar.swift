//
//  ExtensionToolbar.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = Colors.blue
        toolBar.barTintColor = .white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Xong", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        //    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
