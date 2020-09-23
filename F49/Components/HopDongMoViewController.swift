//
//  HopDongMoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class HopDongMoViewController: UIViewController {
    
    var id: Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch id {
        case 0:
            tableView.backgroundColor = UIColor.red
        case 1:
            tableView.backgroundColor = UIColor.blue
        case 2:
            tableView.backgroundColor = UIColor.green
        default:
            break
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
    }
    
    func loadData(){
        switch id {
        case 0:
            return
        case 1:
            return
        case 2:
            return
        default:
            break
        }
    }
    
}

extension HopDongMoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else{
            fatalError()
        }
        
        return cell
    }
    
    
}
