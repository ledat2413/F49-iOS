//
//  ThongTinCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinCamDoViewController: UIViewController {

    @IBOutlet weak var headerView: NavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.title = "Thông tin cầm đồ"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "arrow-left-white"), for: .normal)
    }
    
    @objc func backView(){
        
    }

}
