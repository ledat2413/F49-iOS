//
//  LoginViewController.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class LoginViewController: BaseController {
    
    //MARK: --Vars
    let width = CGFloat(1.0)
    let cornerRadius : CGFloat = 25.0
    var gradientLayer = CAGradientLayer()
    var token: String = ""
    var device: UIDevice?
   let deviceToken = UserHelper.getUserData(key: UserKey.DeviceToken) ?? ""

    //MARK: --IBOutlet
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUI()
        hideKeyboardWhenTappedAround()
        device = UIDevice()
        if UserHelper.getUserData(key: UserKey.Email) != nil {
            emailTextField.text = UserHelper.getUserData(key: UserKey.Email)
        }else {
            emailTextField.text = ""
        }
    }
    
    //MARK: --IBAction
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if !isValidEmail(emailTextField.text) {
            Alert("Tài khoản không hợp lệ")
            return
        } 
        
        self.showActivityIndicator( view: self.view)

        MGConnection.requestToken(APIRouter.Login(grant_type: "password", username: emailTextField.text ?? "", password: passTextField.text ?? ""), Token.self) { [weak self] (result, error) in
            guard let wself = self else {return}
            wself.hideActivityIndicator(view: wself.view)
                guard error == nil else {
                wself.Alert("Sai tài khoản hoặc mật khẩu")
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
                
            }
            if let result = result {
                wself.putFireBase()
                UserHelper.saveUserData(self!.saveButton.isSelected, key: UserKey.AutoLogin)
                UserHelper.saveUserData(self!.emailTextField.text, key: UserKey.Email)
                UserHelper.saveUserData("\(result.token_type) \(result.access_token)", key: UserKey.Token)
                wself.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    deinit {
        print("login deinit")
    }
    
    func putFireBase() {
        MGConnection.requestObject(APIRouter.PutFirebase(email: emailTextField.text ?? "", token: deviceToken, deviceName: device?.name ?? "", flg: true), NotificationVO.self) {[weak self] (result, error) in
            guard let wself = self else { return}
            guard error == nil else {
                wself.Alert("Có lỗi xảy ra")
                return
            }
        }
    }
    
    //MARK: --Func
    
    func displayUI(){
        //        createSpinnerView()
        hideKeyboardWhenTappedAround()
        
        emailTextField.displayTextField(radius: 22, color: UIColor.green)
        emailView.displayShadowView(shadowColor: UIColor.systemGreen, borderColor: UIColor.systemGreen, radius: 22)
        
        passTextField.displayTextField(radius: 22, color: UIColor.green)
        passView.displayShadowView(shadowColor: UIColor.systemGreen, borderColor: UIColor.systemGreen, radius: 22)
        
        loginButton.displayTextField(radius: 22, color: UIColor.orange)
        loginButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        buttonView.displayShadowView(shadowColor: UIColor.orange, borderColor: UIColor.clear, radius: 22)
        
        displayForgotButton()
        
        
    }
    
    func displayForgotButton() {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.systemBlue.cgColor
        border.frame = CGRect(x: 0, y: self.forgotPassButton.frame.size.height - width, width:  self.forgotPassButton.frame.size.width, height: self.forgotPassButton.frame.size.height)
        
        border.borderWidth = width
        self.forgotPassButton.layer.addSublayer(border)
        self.forgotPassButton.layer.masksToBounds = true
    }
}


