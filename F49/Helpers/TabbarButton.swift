//
//  TabbarButton.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class TabbarButton: ButtonBarPagerTabStripViewController{
    
    public func createToolbar(textField: UITextField, selector: Selector){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: selector)
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    func displayTabbarButton(colors: UIColor){
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 13)
        settings.style.selectedBarHeight = 2.0
        settings.style.selectedBarBackgroundColor = colors
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .orange
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .orange
            newCell?.label.textColor = colors
        }
    }
}

