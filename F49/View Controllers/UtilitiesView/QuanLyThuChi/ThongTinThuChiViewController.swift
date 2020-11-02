//
//  ThongTinThuChiViewController.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinThuChiViewController: BaseController {
    
    var idTienIch: Int = 0
    var id: Int = 0
    var dataDetail: [ThongTinThuChi] = []
    var dataVonDauTu: VonDauTu?
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func loadData(){
        
        switch idTienIch {
        case 5:
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
            break
            
        case 8:
            self.showSpinner(onView: self.view)
            MGConnection.requestObject(APIRouter.GetDetailVonDauTu(id: id), VonDauTu.self) { (result, error) in
                self.removeSpinner()
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result {
                    self.dataVonDauTu = result
                    self.tableView.reloadData()
                }
            }
            break
            
        default:
            break
        }
        
    }
    
    func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        loadData()
        
        switch idTienIch {
        case 5:
            navigation.title = "Thông tin thu chi"
            navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
            break
        case 8:
            navigation.title = "Thông tin quản lí vốn"
            navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
            break
        default:
            break
        }
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ThongTinThuChiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch idTienIch {
        case 5:
            return dataDetail.count
        case 8:
            return 6
        default:
            return 0
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        switch idTienIch {
        case 5:
            return 7
        case 8:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch idTienIch {
        case 5:
            return CGFloat((self.tableView.frame.height)/2)/7
        case 8:
            return CGFloat((self.tableView.frame.height)/2)/6
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {
            fatalError()}
        switch idTienIch {
        case 5:
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
        case 8:
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Cửa hàng"
                cell.valueLabel.text = dataVonDauTu?.tenCuaHang
            case 1:
                cell.keyLabel.text = "Ngày giao dịch"
                cell.valueLabel.text = dataVonDauTu?.ngayGiaoDich
            case 2:
                cell.keyLabel.text = "Người thực hiện"
                cell.valueLabel.text = dataVonDauTu?.nguoiThucHien
            case 3:
                cell.keyLabel.text = "Số tiền"
                cell.valueLabel.text = "\(dataVonDauTu?.soTien ?? 0)"
            case 4:
                cell.keyLabel.text = "Nội dung"
                cell.valueLabel.text = dataVonDauTu?.ghiChu
            case 5:
                cell.keyLabel.text = "Ghi chú"
                cell.valueLabel.text = dataVonDauTu?.ghiChu
                
            default:
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
