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
    
    var screenID: String = ""
    var tenTrangThai: String = ""
    var idShop: Int = 0
    var idTab: Int = 0
    fileprivate var dataRutVon: [RutVon] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name.init("Accept"), object: nil)
    }
    
    fileprivate func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
        switch screenID {
        case "RutLai":
            tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
            break
        case "RutVon":
            tableView.register(UINib(nibName: "RutVonTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonTableViewCell")
            break
        default:
            break
        }
        loadData()
    }
    
    @objc func loadData(){
        
        switch screenID {
        case "RutLai":
            break
        case "RutVon":
            self.showActivityIndicator( view: self.view)

            MGConnection.requestArray(APIRouter.GetListRutVon(idShop: idShop, idTab: idTab), RutVon.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    return
                }
                if let result = result {
                    self.dataRutVon = result
//                    
//                    if result.count == 0 {
//                        self.Alert("Không có dữ liệu")
//                    }
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
        switch screenID {
        case "RutLai":
            return 0
        case "RutVon":
            
            return dataRutVon.count
            
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch screenID {
        case "RutLai":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else { fatalError() }
            return cell
        case "RutVon":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVonTableViewCell", for: indexPath) as? RutVonTableViewCell else { fatalError() }
            
            let data = dataRutVon[indexPath.row]
            
            cell.idLabel.text =  "\(indexPath.row + 1)"
            cell.nameLabel.text = data.tenCuaHang
            cell.moneyLabel.text = "\(data.soTien)"
            self.fomatterStringToDate(target: cell.dateLabel, date1: "yyyy-MM-dd'T'HH:mm:ss", data: data.ngayGiaoDich, haveString: false)
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
        switch screenID {
        case "RutLai":
            break
        case "RutVon":
            let itemVC = UIStoryboard.init(name: "RUTLAI", bundle: nil).instantiateViewController(withIdentifier: "RutLaiChiTietViewController") as! RutLaiChiTietViewController
            itemVC.idItem = dataRutVon[indexPath.row].idItem
            itemVC.idTab = idTab
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        default:
            break
        }
    }
    
}
