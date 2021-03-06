//
//  BaseController.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class BaseController: UIViewController {
    
    static var baseView = BaseController()
    
    var vSpinner: UIView!
//    let child = IndicatorViewController()
    
    
    //Validation
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard password != nil else { return false }
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{5,32}")
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
    
    func handlerAlert( message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: UIAlertAction.Style.default, handler: { (action) in
            return completion()
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
    
    func showActivityIndicator(view: UIView) {
        if view.viewWithTag(1000) == nil{
            
           let activityIndicator = NVActivityIndicatorView(frame: view.frame)
            activityIndicator.type = .circleStrokeSpin
            activityIndicator.color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//            activityIndicator.padding =  view.frame.size.width < 400 ? 170 : 190
            activityIndicator.frame.size = view.frame.size.width > 500 ? CGSize(width: 70, height: 70) : CGSize(width: 50, height: 50)
            activityIndicator.backgroundColor = .clear
            activityIndicator.center = view.center
            activityIndicator.tag = 1000

            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
//            UIApplication.shared.beginIgnoringInteractionEvents() //Block screen
        }

    }

    func hideActivityIndicator(view: UIView) {
        if let activityIndicator = view.viewWithTag(1000) as? NVActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
//            UIApplication.shared.endIgnoringInteractionEvents() // Unblock screen
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
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let buttonCancel = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(cancel))
        toolBar.setItems([buttonCancel,spaceButton,button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func cancel(){
        self.view.endEditing(true)
    }
    
    public func createDatePicker(picker: UIDatePicker, selector: Selector, textField: UITextField) {
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
        }
        picker.addTarget(self, action: selector, for: .valueChanged)
        textField.inputView = picker
    }
    
    public func fomatterStringToDate(target: UILabel,date1: String, data: String, haveString: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date1

        let dateForrmater2 = DateFormatter()
        dateForrmater2.dateFormat = "dd/MM/yyyy"
        
        if let  date = dateFormatter.date(from: data) {
            if haveString == true {
                target.text = "Ngày giao dịch: \(dateForrmater2.string(from: date))"
            }else {
                target.text = dateForrmater2.string(from: date)

            }
        }
        
    }
}
