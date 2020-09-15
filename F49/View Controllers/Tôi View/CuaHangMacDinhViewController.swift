//
//  CuaHangMacDinhViewController.swift
//  F49
//
//  Created by Le Dat on 9/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CuaHangMacDinhViewController: UIViewController {

    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
}
