//
//  HopDongThanhLyViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class HopDongThanhLyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HopDongThanhLyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
