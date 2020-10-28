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
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
           self.layer.addSublayer(border)
       }

       func addRightBorderWithColor(color: UIColor, width: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
           self.layer.addSublayer(border)
       }

       func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
           self.layer.addSublayer(border)
       }

       func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
           self.layer.addSublayer(border)
       }
    
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

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

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
}

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

extension UIPickerView {
    func createPicker(tf: UITextField) -> UIPickerView {
        let pickerView = UIPickerView()
        tf.inputView = pickerView
        
        return pickerView
    }
}


extension UIDatePicker{
    func createDatePicker(tf: UITextField) -> UIDatePicker{
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        tf.inputView = datePicker
        return datePicker
    }
}

extension String {
func base64Encoded() -> String? {
    return data(using: .utf8)?.base64EncodedString()
}

func base64Decoded() -> String? {
    var st = self;
    if (self.count % 4 <= 2){
        st += String(repeating: "=", count: (self.count % 4))
    }
    guard let data = Data(base64Encoded: st) else { return nil }
    return String(data: data, encoding: .utf8)
}
}


extension UIImage{
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage(named: "heart")! }
        UIGraphicsEndImageContext()

        return newImage
    }
}
