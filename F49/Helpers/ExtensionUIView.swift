//
//  ExtensionUIView.swift
//  F49
//
//  Created by Le Dat on 9/11/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func display20(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func displayTextField( radius: CGFloat, color: UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func displayShadowView( shadowColor: UIColor, borderColor: UIColor, radius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.9
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = false
    }
    
    func displayShadowView2( shadowColor: UIColor, borderColor: UIColor, radius: CGFloat, offSet: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = false
    }

}

