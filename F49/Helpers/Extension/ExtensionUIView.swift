//
//  ExtensionUIView.swift
//  F49
//
//  Created by Le Dat on 11/12/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//
import UIKit

public extension UIView {

    func onTap(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        addGestureRecognizer(UITapGestureRecognizer(taps: 1, handler: handler))
    }

    func onDoubleTap(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        addGestureRecognizer(UITapGestureRecognizer(taps: 2, handler: handler))
    }

    func onLongPress(_ handler: @escaping (UILongPressGestureRecognizer) -> Void) {
        addGestureRecognizer(UILongPressGestureRecognizer(handler: handler))
    }

    func onSwipeLeft(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .left, handler: handler))
    }

    func onSwipeRight(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .right, handler: handler))
    }

    func onSwipeUp(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .up, handler: handler))
    }

    func onSwipeDown(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .down, handler: handler))
    }

    func onPan(_ handler: @escaping (UIPanGestureRecognizer) -> Void) {
        addGestureRecognizer(UIPanGestureRecognizer(handler: handler))
    }

    func onPinch(_ handler: @escaping (UIPinchGestureRecognizer) -> Void) {
        addGestureRecognizer(UIPinchGestureRecognizer(handler: handler))
    }

    func onRotate(_ handler: @escaping (UIRotationGestureRecognizer) -> Void) {
        addGestureRecognizer(UIRotationGestureRecognizer(handler: handler))
    }

    func onScreenEdgePan(_ handler: @escaping (UIScreenEdgePanGestureRecognizer) -> Void) {
        addGestureRecognizer(UIScreenEdgePanGestureRecognizer(handler: handler))
    }
}


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
    
    func displayCornerRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
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
