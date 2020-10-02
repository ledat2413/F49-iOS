//
//  RutLaiContainerViewController.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RutLaiContainerViewController: BaseController, IndicatorInfoProvider {
    
    //MARK: --Vars
    
    var idTienIch: Int = 0
    var tenTrangThai: String = ""
    var idShop: Int = 0
    var idTab: Int = 0
    var dataRutVon: [RutVon] = []
    //    private var dataTable: [ListRutLai] = []
    //    private var dataTable: String = ""
    //    var text: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpUI()
        
        
    }
    
    func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
        switch idTienIch {
        case 4:
            tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
            break
        case 8:
            tableView.register(UINib(nibName: "RutVonTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonTableViewCell")
            break
        default:
            break
        }
        loadData()
    }
    
    func loadData(){
        
        switch idTienIch {
        case 4:
            //             MGConnection.requestString(APIRouter.GetListRutLai(idShop: idShop, idTab: idTab), returnType: text) { (result, error) in
            //                       guard error == nil else { return }
            //                       if let result = result {
            //                           self.dataTable = result
            //                       }
            //                   }
            break
        case 8:
            self.showSpinner(onView: self.view)
            MGConnection.requestArray(APIRouter.GetListRutVon(idShop: idShop, idTab: idTab), RutVon.self) { (result, error) in
                self.removeSpinner()
                guard error == nil else { return }
                if let result = result {
                    self.dataRutVon = result
                    
                    self.tableView.reloadData()
                }
            }
        default:
            break
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: tenTrangThai)
    }
}

extension RutLaiContainerViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch idTienIch {
        case 4:
            return 0
        case 8:
            return dataRutVon.count
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch idTienIch {
        case 4:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else { fatalError() }
            return cell
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVonTableViewCell", for: indexPath) as? RutVonTableViewCell else { fatalError() }
            let data = dataRutVon[indexPath.row]
            cell.idLabel.text = "\(data.idItem)"
            cell.nameLabel.text = data.tenCuaHang
            cell.moneyLabel.text = "\(data.soTien)"
            cell.dateLabel.text = data.nguoiThucHien
            cell.peopleLabel.text = data.nguoiThucHien
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch idTienIch {
        case 4:
            break
        case 8:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiChiTietViewController") as! RutLaiChiTietViewController
            itemVC.idItem = dataRutVon[indexPath.row].idItem
            itemVC.idTab = idTab
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        default:
            break
        }
    }
    
}