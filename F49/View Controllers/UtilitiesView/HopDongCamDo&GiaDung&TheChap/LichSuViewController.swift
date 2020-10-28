//
//  LichSuViewController.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class LichSuViewController: UIViewController {
    
    var dataLichSuGiaoDich: [LichSuGiaoDich] = []
    var dataLichSuVayNo: [LichSuVayNo] = []
    var soHopDong: String = ""
    var tenKH: String = ""
    var idHopDong: Int = 0
    var idKhachHang: Int = 0
    var code: Int = 0
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNavigation()
        displayTableView()
        loadLichSuData()
    
    }
    
    func displayNavigation(){
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        switch code {
        case 0:
            navigation.title = "Lịch sử giao dịch"
        default:
            navigation.title = "Lịch sử vay"
        }
    }
    
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LichSuTableViewCell", bundle: nil), forCellReuseIdentifier: "LichSuTableViewCell")
        tableView.register(UINib(nibName: "LichSu2TableViewCell", bundle: nil), forCellReuseIdentifier: "LichSu2TableViewCell")
        
    }
    
    func loadLichSuData(){
        switch code {
        case 0:
            MGConnection.requestArray(APIRouter.GetLichSuGiaoDich(id: idHopDong), LichSuGiaoDich.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataLichSuGiaoDich = result
                    self.tableView.reloadData()
                }
            }
        default:
            MGConnection.requestArray(APIRouter.GetLichSuVayNo(id: idKhachHang), LichSuVayNo.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataLichSuVayNo = result
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
}

extension LichSuViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch code {
        case 0:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ChiTietLichSuViewController") as! ChiTietLichSuViewController
            itemVC.code = code
            itemVC.idLoaiGiaoDich = dataLichSuGiaoDich[indexPath.row].idLoaiGiaoDich
            itemVC.modalPresentationStyle = .overCurrentContext
            itemVC.modalTransitionStyle = .crossDissolve
            self.present(itemVC, animated: true, completion: nil)
        default:
             let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ChiTietLichSuViewController") as! ChiTietLichSuViewController
             itemVC.code = code
             itemVC.idHopDong = dataLichSuVayNo[indexPath.row].id
             itemVC.modalPresentationStyle = .overCurrentContext
             itemVC.modalTransitionStyle = .crossDissolve
            self.present(itemVC, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch code {
        case 0:
            switch section {
            case 0:
                return 1
            case 1:
                return dataLichSuGiaoDich.count
            default:
                return 0
            }
        default:
            switch section {
            case 0:
                return 1
            case 1:
                return dataLichSuVayNo.count
            default:
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch code {
        case 0:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuTableViewCell", for: indexPath) as? LichSuTableViewCell else { fatalError() }
                cell.titleLabel.text = "Số HĐ:"
                cell.valueLabel.text = soHopDong
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSu2TableViewCell", for: indexPath) as? LichSu2TableViewCell else { fatalError() }
                let data = dataLichSuGiaoDich[indexPath.row]
                cell.idLabel.text = "\(data.id)"
                cell.titleLabel.text = "Ngày giao dịch: \(data.ngayGiaoDich)"
                cell.choVayLabel.text = "\(data.choVay)"
                cell.noGocLabel.text = "\(data.noGoc)"
                cell.nhanVienLabel.text = data.nhanVien
                return cell
            default:
                return UITableViewCell()
            }
        default:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuTableViewCell", for: indexPath) as? LichSuTableViewCell else { fatalError() }
                cell.titleLabel.text = "Tên KH:"
                cell.valueLabel.text = tenKH
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "LichSu2TableViewCell", for: indexPath) as? LichSu2TableViewCell else { fatalError() }
                let data = dataLichSuVayNo[indexPath.row]
                cell.idLabel.text = "\(data.id)"
                cell.titleLabel.text = data.tenCuaHang
                cell.choVayTitleLabel.text = "Số tiền"
                cell.choVayLabel.text = "\(data.soTien)"
                
                cell.noGocTitleLabel.text = "Gốc đã thu"
                cell.noGocLabel.text = "\(data.soTien)"
                
                cell.nhanVienTitleLabel.text = "Tình trạng"
                cell.nhanVienImageView.image = UIImage(named: "icon-content-trangthai")
                cell.nhanVienLabel.text = data.tinhTrang
                cell.nhanVienLabel.textColor = Colors.orange
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
}
