//
//  MatKhauViewController.swift
//  F49
//
//  Created by Le Dat on 9/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class MatKhauViewController: UIViewController {
    
    
    @IBOutlet weak var headerView: NavigationBar!
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var oldPassTextField: UITextField!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var confirmNewPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.title = "Đổi mật khẩu"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        cornerRadius(oldPassTextField)
        cornerRadius(newPassTextField)
        cornerRadius(confirmNewPassTextField)
        cornerRadius(cancelButton)
        cornerRadius(updateButton)
        updateButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func cornerRadius(_ view: UIView){
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
    }
}
