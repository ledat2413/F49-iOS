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
    var dataChoTietLichSuGiaoDich: ChiTietVayNo?
    
    
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
            self.showActivityIndicator( view: self.view)

            MGConnection.requestObject(APIRouter.GetChiTietLichSuGiaoDich(idGiaoDich: idLoaiGiaoDich, idHopDong: idHopDong), ChiTietVayNo.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    
                    return}
                if result == nil {
                    self.Alert("Không có dữ liệu")
                }
                
                if let result = result {
                    self.dataChoTietLichSuGiaoDich = result
                    
                    self.tableView.reloadData()
                }
            }
            break
        default:
            self.showActivityIndicator( view: self.view)

            MGConnection.requestObject(APIRouter.GetChiTietLichSuVayNo(idHopDong: idHopDong), ChiTietVayNo.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
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
            switch indexPath.section {
            case 0:
                cell.ui(keyString: "Tên KH", valueString: dataChoTietLichSuGiaoDich?.tenKhachHang ?? "")
            case 1:
                cell.ui(keyString: "Cửa hàng", valueString: dataChoTietLichSuGiaoDich?.tenCuaHang ?? "")
            case 2:
                cell.ui(keyString: "Số HĐ", valueString: dataChoTietLichSuGiaoDich?.soHopDong ?? "")
            case 3:
                cell.ui(keyString: "Ngày vay", valueString: dataChoTietLichSuGiaoDich?.ngayVay ?? "")
            case 4:
                cell.ui(keyString: "Hình thức vay", valueString: dataChoTietLichSuGiaoDich?.hinhThucVay ?? "")
            case 5:
                cell.ui(keyString: "Số tiền", valueString: "\(dataChoTietLichSuGiaoDich?.soTien ?? 0)")
            case 6:
                cell.ui(keyString: "Gốc đã thu", valueString: "\(dataChoTietLichSuGiaoDich?.gocDaThu ?? 0)")
            case 7:
                cell.ui(keyString: "Lãi đã thu", valueString: "\(dataChoTietLichSuGiaoDich?.laiDaThu ?? 0)")
            case 8:
                cell.ui(keyString: "Tình trạng", valueString: dataChoTietLichSuGiaoDich?.tinhTrang ?? "")
                cell.valueLabel.textColor = .orange
            default:
                return cell
            }        default:
                switch indexPath.section {
                case 0:
                    cell.ui(keyString: "Tên KH", valueString: dataChiTietLichSuVayNo?.tenKhachHang ?? "")
                case 1:
                    cell.ui(keyString: "Cửa hàng", valueString: dataChiTietLichSuVayNo?.tenCuaHang ?? "")
                case 2:
                    cell.ui(keyString: "Số HĐ", valueString: dataChiTietLichSuVayNo?.soHopDong ?? "")
                case 3:
                    cell.ui(keyString: "Ngày vay", valueString: dataChiTietLichSuVayNo?.ngayVay ?? "")
                case 4:
                    cell.ui(keyString: "Hình thức vay", valueString: dataChiTietLichSuVayNo?.hinhThucVay ?? "")
                case 5:
                    cell.ui(keyString: "Số tiền", valueString: "\(dataChiTietLichSuVayNo?.soTien ?? 0)")
                case 6:
                    cell.ui(keyString: "Gốc đã thu", valueString: "\(dataChiTietLichSuVayNo?.gocDaThu ?? 0)")
                case 7:
                    cell.ui(keyString: "Lãi đã thu", valueString: "\(dataChiTietLichSuVayNo?.laiDaThu ?? 0)")
                case 8:
                    cell.ui(keyString: "Tình trạng", valueString: dataChiTietLichSuVayNo?.tinhTrang ?? "")
                    cell.valueLabel.textColor = .orange
                default:
                    return cell
                }
        }
        return cell
        
    }
    
    
}
