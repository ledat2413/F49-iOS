//
//  OptionViewController.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    //MARK: --Vars
    var idHopDong: Int = 0
    var idKhachHang: Int = 0
    var soHopDong: String = ""
    var tenKhachHang: String = ""
    var ngayHieuLuc: String = ""
    
    var data: Int?
    //    var dataLichSuGiaoDich: [LichSuGiaoDich] = []
    var countGiaoDich: Int = 0
    var countVayNo: Int = 0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ThongTinHopDongTableViewCell", bundle: nil), forCellReuseIdentifier: "ThongTinHopDongTableViewCell")
        tableView.register(UINib(nibName: "TacVuTableViewCell", bundle: nil), forCellReuseIdentifier: "TacVuTableViewCell")
        loadCountLichSuGiaoDich()
        loadCountLichSuVayNo()
    }
    
    //MARK: --Func
    
    func loadCountLichSuVayNo() {
        MGConnection.requestInt(APIRouter.GetCountLichSuVayNo(id: idKhachHang), returnType: data) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.countVayNo = result
                self.tableView.reloadData()
            }
        }
    }
    
    func loadCountLichSuGiaoDich() {
        MGConnection.requestInt(APIRouter.GetCountLichSuGiaoDich(id: idHopDong), returnType: data) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.countGiaoDich = result
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: --IBAction
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension OptionViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height / 4)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TacVuTableViewCell", for: indexPath) as? TacVuTableViewCell else {
                fatalError()}
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThongTinHopDongTableViewCell", for: indexPath) as? ThongTinHopDongTableViewCell else { fatalError()}
            switch indexPath.row {
            case 0:
                cell.thumnailImageView.image = UIImage(named: "icon-lichsugiaodich")
                cell.thumbnailTitleLabel.text = "Lịch sử giao dịch"
                cell.thumbnailNumberLabel.text = "( \(countGiaoDich) )"
                cell.thumbnailNumberLabel.textColor = .red
            case 1:
                cell.thumnailImageView.image = UIImage(named: "icon-lichsuvay")
                cell.thumbnailTitleLabel.text = "Lịch sử vay"
                cell.thumbnailNumberLabel.text = "( \(countVayNo) )"
                cell.thumbnailNumberLabel.textColor = .red
            case 2:
                cell.thumnailImageView.image = UIImage(named: "icon-lichsuvay")
                cell.thumbnailTitleLabel.text = "Đóng lãi"
                cell.thumbnailNumberLabel.isHidden = true
                
            default:
                return cell
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: //LichSuGiaoDich
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "LichSuViewController") as! LichSuViewController
                itemVC.code = 0
                itemVC.modalPresentationStyle = .overCurrentContext
                itemVC.modalTransitionStyle = .crossDissolve
                itemVC.idHopDong = self.idHopDong
                itemVC.soHopDong = self.soHopDong
                self.present(itemVC, animated: true, completion: nil)
            case 1: //LichSuVayNo
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "LichSuViewController") as!LichSuViewController
                itemVC.code = 1
                itemVC.modalPresentationStyle = .overCurrentContext
                itemVC.modalTransitionStyle = .crossDissolve
                itemVC.idKhachHang = self.idKhachHang
                itemVC.tenKH = self.tenKhachHang
                self.present(itemVC, animated: true, completion: nil)
            case 2: //LichSuVayNo
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "DongLaiViewController") as!DongLaiViewController
                itemVC.modalPresentationStyle = .overCurrentContext
                itemVC.modalTransitionStyle = .crossDissolve
                itemVC.idHopDong = self.idHopDong
                itemVC.ngayHieuLuc = self.ngayHieuLuc
                self.present(itemVC, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    
}
