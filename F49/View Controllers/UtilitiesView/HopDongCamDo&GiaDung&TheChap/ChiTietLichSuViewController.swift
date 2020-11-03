//
//  ChiTietLichSuViewController.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ChiTietLichSuViewController: BaseController {
    
    var code: Int = 0
    
    var idHopDong: Int = 0
    var idLoaiGiaoDich: Int = 0
    
    var dataChiTietLichSuVayNo: ChiTietVayNo?
    
    
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TacVuTableViewCell", bundle: nil), forCellReuseIdentifier: "TacVuTableViewCell")
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        displayNavigation()
        loadData()
        
    }
    
    func loadData(){
        switch code {
        case 0:
            //            MGConnection.
            MGConnection.requestObject(APIRouter.GetChiTietLichSuGiaoDich(idGiaoDich: idLoaiGiaoDich, idHopDong: idHopDong), ChiTietVayNo.self) { (result, error) in
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    
                    return}
                if let result = result {
                    self.dataChiTietLichSuVayNo = result
                    if result.soHopDong.isEmpty {
                        self.Alert("Không có dữ liệu")
                    }
                    self.tableView.reloadData()
                }
            }
            break
        default:
            MGConnection.requestObject(APIRouter.GetChiTietLichSuVayNo(idHopDong: idHopDong), ChiTietVayNo.self) { (result, error) in
                guard error == nil else {
                    
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    return}
                if let result = result {
                    self.dataChiTietLichSuVayNo = result
                    if result.soHopDong.isEmpty {
                        self.Alert("Không có dữ liệu")
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func displayNavigation() {
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        switch code {
        case 0:
            navigation.title = "Chi tiết lịch sử giao dịch"
            
        default:
            navigation.title = "Chi tiết lịch sử vay nợ"
            
        }
    }
    @objc func backView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ChiTietLichSuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch code {
        case 0:
            return 12
        default:
            return 9
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch code {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
        
        switch code {
        case 0:
            return cell
        default:
            switch indexPath.section {
            case 0:
                cell.keyLabel.text = "Tên KH"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.tenKhachHang
            case 1:
                cell.keyLabel.text = "Cửa hàng"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.tenCuaHang
            case 2:
                cell.keyLabel.text = "Số HĐ"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.soHopDong
            case 3:
                cell.keyLabel.text = "Ngày vay"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.ngayVay
            case 4:
                cell.keyLabel.text = "Hình thức vay"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.hinhThucVay
            case 5:
                cell.keyLabel.text = "Số tiền"
                cell.valueLabel.text = "\(dataChiTietLichSuVayNo?.soTien ?? 0)"
            case 6:
                cell.keyLabel.text = "Gốc đã thu"
                cell.valueLabel.text = "\(dataChiTietLichSuVayNo?.gocDaThu ?? 0)"
            case 7:
                cell.keyLabel.text = "Lãi thu"
                cell.valueLabel.text = "\(dataChiTietLichSuVayNo?.laiDaThu ?? 0)"
            case 8:
                cell.keyLabel.text = "Tình trạng"
                cell.valueLabel.text = dataChiTietLichSuVayNo?.tinhTrang
                cell.valueLabel.textColor = .orange
            default:
                return cell
            }
        }
        return cell
        
    }
    
    
}
