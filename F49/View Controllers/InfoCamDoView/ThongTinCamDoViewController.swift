//
//  ThongTinCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/18/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThongTinCamDoViewController: UIViewController {
    
    //MARK: --Vars
    public var id: String = ""
    public var index: Int = 0
    public var dataInfoA: [CamDoChiTiet] = []
    public var dataInfoB: [DinhGiaChiTiet] = []
    public var dataInfoC: [DoGiaDungChiTiet] = []
    
    //    var callback: ((_ index: Int) -> Void)?
    
    
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()
        
        
        switch index {
        case 0:
            headerView.title = "Thông tin cầm đồ"
            
            break
        case 1:
            headerView.title = "Thông tin định giá"
           
            break
        case 2:
            headerView.title = "Thông tin cầm đồ gia dụng"
            break
        default:
            break
        }
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        tableView.register(UINib(nibName: "CheckBoxTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckBoxTableViewCell")
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func loadInfo() {
        
        switch index {
        case 0:
            MGConnection.requestArray(APIRouter.GetChiTietCamDo(id: Int(id) ?? 0 ), CamDoChiTiet.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataInfoA = result
                    self.tableView.reloadData()
                }
            }
            return
        case 1:
            MGConnection.requestArray(APIRouter.GetChiTietDinhGia(id: Int(id) ?? 0 ), DinhGiaChiTiet.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataInfoB = result
                    self.tableView.reloadData()
                }
            }
            return
        case 2:
            MGConnection.requestArray(APIRouter.GetChiTietDoGiaDung(id: Int(id) ?? 0 ), DoGiaDungChiTiet.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataInfoC = result
                    self.tableView.reloadData()
                }
            }
            return
        default:
            break
        }
        
        
    }
    
}

extension ThongTinCamDoViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch index {
        case 0:
            return CGFloat(tableView.frame.size.height / 7)
            
        case 1:
            return CGFloat(tableView.frame.size.height / 6)
            
        case 2:
            return CGFloat(tableView.frame.size.height / 5)
            
        default:
            return CGFloat()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch index {
        case 0:
            return dataInfoA.count
        case 1:
            return dataInfoB.count
        case 2:
            return dataInfoC.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch index {
        case 0:
            return 7
        case 1:
            return 6
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch index {
        case 0:
            let data = dataInfoA[indexPath.row]
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Họ và tên"
                cell.valueLabel.text = data.name
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Số tiền"
                cell.valueLabel.text = "300.000.000Đ"
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Điện thoại"
                cell.valueLabel.text = data.phone
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Nhãn hiệu"
                cell.valueLabel.text = data.brand
                return cell
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Mô tả"
                cell.valueLabel.text = data.descriptionn
                return cell
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Ngày đăng kí"
                cell.valueLabel.text = data.date
                return cell
            case 6:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell", for: indexPath) as? CheckBoxTableViewCell else {fatalError()}
                cell.keyLabel.text = "Xử lí"
                if data.active == true {
                    cell.valueImageView.image = UIImage(named: "login-checked")
                }
                return cell
                
            default:
                return UITableViewCell()
            }
        case 1:
            let data = dataInfoB[indexPath.row]
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Tiêu đề"
                cell.valueLabel.text = data.name
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Họ và tên"
                cell.valueLabel.text = data.email
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Điện thoại"
                cell.valueLabel.text = data.phone
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as? ImageTableViewCell else {fatalError()}
                cell.keyLabel.text = "Hình ảnh"
                cell.valueImage.sd_setImage(with: URL(string: data.image), placeholderImage: UIImage(named: "heart.fill"))
                return cell
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Ngày đăng ký"
                cell.valueLabel.text = data.regDate
                return cell
                
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell", for: indexPath) as? CheckBoxTableViewCell else {fatalError()}
                cell.keyLabel.text = "Xử lí"
                if data.active == true {
                    cell.valueImageView.image = UIImage(named: "login-checked")
                }
                return cell
                
            default:
                return UITableViewCell()
            }
        case 2:
            let data = dataInfoC[indexPath.row]
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Tiêu đề"
                cell.valueLabel.text = data.name
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Điện thoại"
                cell.valueLabel.text = data.phone
                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Tài sản"
                cell.valueLabel.text = data.asset
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
                cell.keyLabel.text = "Ngày đăng ký"
                cell.valueLabel.text = data.date
                return cell
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell", for: indexPath) as? CheckBoxTableViewCell else {fatalError()}
                cell.keyLabel.text = "Xử lí"
                if data.active == true {
                    cell.valueImageView.image = UIImage(named: "login-checked")
                }
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
