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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.checkLogin), name: Notification.Name("LoginNotification"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        checkLogin()
    }
    
    
    private func setUpUI(){
        view.backgroundColor = UIColor(patternImage: UIImage(named: "loading-bg")!)
            imageView.image = UIImage(named: "hinh_loading")
    }
    
    @objc private func checkLogin(){
        if UserToken.getAccessToken() == nil {
            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
            self.present(itemVC, animated: true, completion: nil)
        }else {
            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "TabarController")
            self.present(itemVC, animated: true, completion: nil)
        }
    }

}
