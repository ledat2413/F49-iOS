//
//  SplashScreenViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import ChameleonFramework
import SDWebImage

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var loginSuccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        setUpUI()
        print(UserHelper.getUserData(key: UserKey.Token) ?? "")
        print(UserHelper.getAutoLogin())
        
        if UserHelper.getAutoLogin() == true && UserHelper.getUserData(key: UserKey.Token) != nil{
            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabarController")
            loginSuccess = true
            self.navigationController?.pushViewController(itemVC, animated: true)
        }else{
            UserHelper.clearUserData(key: UserKey.Token)
            UserHelper.clearUserData(key: UserKey.AutoLogin)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        NotificationCenter.default.addObserver(self, selector: #selector(checkLogin), name: NSNotification.Name.init("Login"), object: nil)
        if !loginSuccess {
            checkLogin()
        }
    }
    
    
    
    private func setUpUI(){
        imageView.image = UIImage(named: "hinh_loading")
    }
    
    @objc private func checkLogin(){
        
        if UserHelper.getUserData(key: UserKey.Token) == nil{
            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            self.present(itemVC, animated: true, completion: nil)
        }else {
            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabarController")
            self.navigationController?.pushViewController(itemVC, animated: true)
//            self.present(itemVC, animated: true, completion: nil)
        }
    }
    
}
