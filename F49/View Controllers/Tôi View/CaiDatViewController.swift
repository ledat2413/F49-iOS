//
//  CaiDatViewController.swift
//  F49
//
//  Created by Le Dat on 9/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CaiDatViewController: UIViewController {
    
    @IBOutlet weak var headerView: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.title = "Cài đặt"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        
    }
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn {
            print("ON")
            let alert = UIAlertController(title: "Xác nhận lại mật khẩu", message: "Message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            print("OFF")
        }
    }
}
