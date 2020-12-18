//
//  TabbarView.swift
//  F49
//
//  Created by Le Dat on 11/20/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class TabbarView: UITabBarController{
    let button = UIButton.init(type: .custom)
    let imageView = UIImageView.init(image: UIImage(named: "qrcode"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(openCamera), for: .touchUpInside)

        
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        button.backgroundColor = UIColor.systemGreen
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGreen.cgColor
        imageView.frame = CGRect(x: button.center.x - 100, y: button.center.y, width: 22, height: 22)
        button.addSubview(imageView)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.tabBar.center.y - 65, width: 64, height: 64)
        button.layer.cornerRadius = 32
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func openCamera(){
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CodeQRViewController")
        itemVC.modalPresentationStyle = .overCurrentContext
        itemVC.modalTransitionStyle = .crossDissolve
        self.present(itemVC, animated: true, completion: nil)
    }

}
