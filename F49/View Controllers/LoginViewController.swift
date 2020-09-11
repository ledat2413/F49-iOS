//
//  LoginViewController.swift
//  F49
//
//  Created by Le Dat on 9/8/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: --Vars
    let width = CGFloat(1.0)
    let cornerRadius : CGFloat = 25.0
    var gradientLayer = CAGradientLayer()
    
    
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
        
    }
    
    //MARK: --IBAction
    @IBAction func loginButtonPressed(_ sender: Any) {
        MGConnection.requestToken(APIRouter.Login(grant_type: "password", username: emailTextField.text ?? "", password: passTextField.text ?? ""), Token.self) { (result, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Thông Báo", message: "Sai tài khoản hoặc mật khẩu", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                UserToken.save("\(result.token_type) \(result.access_token)")
                print("Login Success")
                self.homeView()
                
                
            }
        }
        NotificationCenter.default.post(name: Notification.Name("LoginNotification"), object: nil)
    }
    
    
    //MARK: --Func
    func displayUI(){
        displayShadowView(emailView)
        displayShadowView(passView)
        displayTextField(emailTextField)
        displayTextField(passTextField)
        displayShadowView(buttonView)
        displayTextField(loginButton)
        displayForgotButton()
        loginButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
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
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.9
        view.layer.cornerRadius = 25
    }
    
    func displayTextField(_ textField: UIView){
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard password != nil else { return false }
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        return passwordTest.evaluate(with: password)
    }
    
    private func homeView(){
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SplashScreenViewController")
        self.present(itemVC, animated: true, completion: nil)
    }
    
    
}

