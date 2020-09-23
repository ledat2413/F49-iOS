//
//  HopDongMoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HopDongMoViewController: UIViewController,IndicatorInfoProvider {
    
    public var value: String = ""
    var id: Int = 0
    var idShop: Int = 0
    var dataHopDong: [HopDongTheoLoai] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        switch id {
        case 0:
            return tableView.backgroundColor = .black
        case 1:
            return tableView.backgroundColor = .red
        case 4:
            return tableView.backgroundColor = .blue
        default:
            break
        }
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: Notification.Name("IdShop"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
    }
    
    @objc func reloadData(){
        
    }
    
    func loadData(){
        MGConnection.requestArray(APIRouter.GetListHopDongTheoLoai(id: 18, loaidHD: id), HopDongTheoLoai.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataHopDong = result
                self.tableView.reloadData()
            }
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: value)
    }
    
}

extension HopDongMoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else{
            fatalError()
        }
        
        return cell
    }
}


