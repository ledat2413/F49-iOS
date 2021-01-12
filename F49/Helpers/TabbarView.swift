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
        imageView.frame = CGRect(x:19, y: 19, width: 22, height: 22)
//        imageView.center = UIColor.red
        button.addSubview(imageView)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        
        self.tabBar.backgroundColor = UIColor.white;
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect.init(x: self.tabBar.center.x - 30, y: (self.tabBar.frame.maxY - self.tabBar.bounds.height) + 2, width: 60, height: 60)
        button.layer.cornerRadius = 30
//        imageView.center = button.center
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
