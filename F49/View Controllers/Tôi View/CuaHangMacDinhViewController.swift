//
//  CuaHangMacDinhViewController.swift
//  F49
//
//  Created by Le Dat on 9/15/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CuaHangMacDinhViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: NavigationBar!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        headerView.title = "Cửa hàng mặc định"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        acceptButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        displayButton(acceptButton)
        displayButton(cancelButton)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayButton(_ button: UIButton){
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
   
}

extension CuaHangMacDinhViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopUITableViewCell", for: indexPath) as? ShopUITableViewCell else {
            fatalError()
        }
        
        return cell
    }
    
    
}
