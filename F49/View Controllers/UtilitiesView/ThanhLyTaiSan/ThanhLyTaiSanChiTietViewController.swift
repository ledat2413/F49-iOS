//
//  ThanhLyTaiSanChiTietViewController.swift
//  F49
//
//  Created by Le Dat on 10/3/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThanhLyTaiSanChiTietViewController: UIViewController {
    
    //MARK: --Vars
    var idTaiSan: Int = 0
    var dataTaiSan: TaiSanChiTiet?
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUI()
    }
    
    //MARK: --Navigation
    
    func displayNavigation(){
        navigation.title = "Thông tin thanh lý tài sản"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        navigation.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: --Func
    
    func displayUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        loadDataChiTiet()
        displayNavigation()
    }
    
    func loadDataChiTiet(){
        MGConnection.requestObject(APIRouter.GetDetailTaiSan(id: idTaiSan), TaiSanChiTiet.self) { (result, error) in
            guard error == nil else {
                return
            }
            if let result = result {
                self.dataTaiSan = result
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ThanhLyTaiSanChiTietViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height / 12)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {
            fatalError()
        }
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Số hợp đồng"
            cell.valueLabel.text = dataTaiSan?.soHopDong
        case 1:
            cell.keyLabel.text = "Tên tài sản"
            cell.valueLabel.text = dataTaiSan?.tenVatCamCo
        case 2:
            cell.keyLabel.text = "Mô tả"
            cell.valueLabel.text = dataTaiSan?.moTa
        case 3:
            cell.keyLabel.text = "Trạng thái"
            cell.valueLabel.text = dataTaiSan?.tenTrangThai
            cell.valueLabel.textColor = UIColor.systemYellow
        case 4:
            cell.keyLabel.text = "Ngày vào"
            cell.valueLabel.text = dataTaiSan?.ngayLuuKho
        case 5:
            cell.keyLabel.text = "Ngày ra"
            cell.valueLabel.text = dataTaiSan?.ngayTra
        case 6:
            cell.keyLabel.text = "CK Xe.KCC"
            cell.valueLabel.text = dataTaiSan?.xkxkcc
        case 7:
            cell.keyLabel.text = "Có khìa khoá"
            cell.valueLabel.isEnabled = true
            cell.valueImage.isHidden = false
            if dataTaiSan?.coChiaKhoa == true {
                cell.valueImage.image = UIImage(named: "login-checked")
            }else{
                cell.valueImage.image = UIImage(named: "login-check")
            }
        case 8:
            cell.keyLabel.text = "Mật khẩu"
            cell.valueLabel.text = dataTaiSan?.matKhau
        case 9:
            cell.keyLabel.text = "Nơi lưu"
            cell.valueLabel.text = dataTaiSan?.viTriDeDo
        case 10:
            cell.keyLabel.text = "Ngày TL"
            cell.valueLabel.text = dataTaiSan?.ngayThanhLy
        case 11:
            cell.keyLabel.text = "Số tiền TL"
            cell.valueLabel.text = dataTaiSan?.giaThanhLy
            
        default:
            return cell
        }
        return cell
        
    }
    
}
