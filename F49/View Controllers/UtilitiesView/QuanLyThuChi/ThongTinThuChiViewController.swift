//
//  ThongTinThuChiViewController.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinThuChiViewController: BaseController {
    
    var id: Int = 0
    var dataDetail: [ThongTinThuChi] = []
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func loadData(){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetDetailThuChiByID(id: id), ThongTinThuChi.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataDetail = result
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        loadData()
        
        navigation.title = "Thông tin thu chi"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ThongTinThuChiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDetail.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((self.tableView.frame.height)/2)/7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {
        fatalError()}
        let data = dataDetail[indexPath.row]
        switch indexPath.section {
        case 0:
            cell.keyLabel.text = "Cửa hàng"
            cell.valueLabel.text = data.tenCuaHang
            return cell
        case 1:
            cell.keyLabel.text = "Ngày thực hiện"
            cell.valueLabel.text = data.ngayThucHien
            return cell
        case 2:
            cell.keyLabel.text = "Thu"
            cell.valueLabel.text = data.thu
            return cell
        case 3:
            cell.keyLabel.text = "Chi"
            cell.valueLabel.text = data.chi
            return cell
        case 4:
            cell.keyLabel.text = "Người thực hiện"
            cell.valueLabel.text = data.nguoiThucHien
            return cell
        case 5:
            cell.keyLabel.text = "Lý do"
            cell.valueLabel.text = data.lyDo
            return cell
        case 6:
            cell.keyLabel.text = "Ghi chú"
            cell.valueLabel.text = data.ghiChu
            return cell
        default:
            return cell
        }
    }
}
