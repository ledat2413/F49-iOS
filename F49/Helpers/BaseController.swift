//
//  BaseController.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit

class BaseController: UIViewController {
    var vSpinner: UIView!
    
    
    func showSpinner1(onView : UIView, spinnerView : UIView) {
           spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

           let ai = UIActivityIndicatorView.init(style: .whiteLarge)
           ai.startAnimating()
           ai.center = spinnerView.center
           
           DispatchQueue.main.async {
               print("show spinner")
               spinnerView.addSubview(ai)
               onView.addSubview(spinnerView)
        
           }
       }
       
       func removeSpinner1(spinnerView : UIView) {
           print("remove spinner")
           DispatchQueue.main.async {
               spinnerView.removeFromSuperview()
           }
       }
    
    //Validation
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard password != nil else { return false }
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,32}")
        return passwordTest.evaluate(with: password)
    }
    
    //Alert
    func Alert(_ message: String){
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertWithHandle(_ message: String){
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true) {
            
        }
    }
    
    
    //Hide Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //Spinner
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        
        DispatchQueue.main.async {
            print("show spinner")

            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        print("remove spinner")
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    
    //Convert
    public static func convertImageToBase64String(image : UIImage ) -> String
    {
        let strBase64 =  image.pngData()?.base64EncodedString()
        return strBase64!
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func createToolbar(textField: UITextField, selector: Selector){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: selector)
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    public func createDatePicker(picker: UIDatePicker, selector: Selector, textField: UITextField) {
        picker.datePickerMode = .date
        picker.addTarget(self, action: selector, for: .valueChanged)
        textField.inputView = picker
    }
}
