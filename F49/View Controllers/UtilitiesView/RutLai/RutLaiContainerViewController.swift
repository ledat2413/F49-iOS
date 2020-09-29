//
//  RutLaiContainerViewController.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class RutLaiContainerViewController: UIViewController,IndicatorInfoProvider {
    
    //MARK: --Vars
    
    var value: String = ""
    var idShop: Int = 0
    var id: Int = 0
//    private var dataTable: [ListRutLai] = []
    private var dataTable: String = ""
    var text: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
//        loadData()

    }
    
    func loadData(){
       
        MGConnection.requestString(APIRouter.GetListRutLai(idShop: idShop, idTab: id), returnType: text) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataTable = result
            }
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: value)
    }
    
    
    
}

extension RutLaiContainerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else { fatalError() }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
}
