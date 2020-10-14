//
//  HopDongMoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HopDongMoViewController: BaseController,IndicatorInfoProvider {
    
    public var value: String = ""
    var id: Int = 0
    var idShop: Int = 0
    var idStatus: String?
    var keyWord: String?
    var dataHopDong: [HopDongTheoLoai] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name.init("DongLai"), object: nil)
       
    }
    
   @objc func loadData(){
        var params: [String: Any] = ["idCuaHang": idShop, "loaiHD": id]
        
        if let idStatus = self.idStatus {
            params["trangThai"] = idStatus
        }
        if let keyWord = self.keyWord {
            params["tuKhoa"] = keyWord
        }
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetListHopDongTheoLoai(params: params), HopDongTheoLoai.self) { (result, error) in
            self.removeSpinner()
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
        return dataHopDong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else{
            fatalError()
        }
        
        let data = dataHopDong[indexPath.row]
        
        cell.idLabel.text = "\(data.id)"
        cell.id2Label.text = data.soHopDong
        cell.tangGiamLabel.text = "\(data.soNgayQuaHan)"
        cell.nameLabel.text = data.tenKhachHang
        cell.tienLabel.text = data.duNoHienTai
        cell.tongLabel.text = data.laiPhaiThu
        cell.backgroundColor = UIColor(hexString: data.maMau)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ChiTietHopDongViewController") as! ChiTietHopDongViewController
        itemVC.id = dataHopDong[indexPath.row].id
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    

}


