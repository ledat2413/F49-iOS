//
//  OptionViewController.swift
//  F49
//
//  Created by Le Dat on 10/5/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class OptionViewController: BaseController {
    
    //MARK: --Vars
    var idHopDong: Int = 0
    var idKhachHang: Int = 0
    var soHopDong: String = ""
    var tenKhachHang: String = ""
    var ngayHieuLuc: String = ""
    
    private var heightHeaderSection: CGFloat = 40
    
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
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //MARK: --Func
    
    func loadCountLichSuVayNo() {
        MGConnection.requestInt(APIRouter.GetCountLichSuVayNo(idKhachHang: idKhachHang), returnType: data) { (result, error) in
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
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeaderSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TacVuTableViewCell") as? TacVuTableViewCell else {
            fatalError()}
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height / 3 - 20 )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThongTinHopDongTableViewCell", for: indexPath) as? ThongTinHopDongTableViewCell else { fatalError()}
            cell.thumnailImageView.image = UIImage(named: "icon-lichsugiaodich")
            cell.thumbnailTitleLabel.text = "Lịch sử giao dịch"
            cell.thumbnailNumberLabel.text = "( \(countGiaoDich) )"
            cell.thumbnailNumberLabel.textColor = .red
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThongTinHopDongTableViewCell", for: indexPath) as? ThongTinHopDongTableViewCell else { fatalError()}
            cell.thumnailImageView.image = UIImage(named: "icon-lichsuvay")
            cell.thumbnailTitleLabel.text = "Lịch sử vay"
            cell.thumbnailNumberLabel.text = "( \(countVayNo) )"
            cell.thumbnailNumberLabel.textColor = .red
            return cell
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThongTinHopDongTableViewCell", for: indexPath) as? ThongTinHopDongTableViewCell else { fatalError()}
            cell.thumnailImageView.image = UIImage(named: "icon-lichsuvay")
            cell.thumbnailTitleLabel.text = "Thu lãi"
            cell.thumbnailNumberLabel.isHidden = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1: //LichSuGiaoDich
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "LichSuViewController") as! LichSuViewController
            itemVC.code = 0
            itemVC.modalPresentationStyle = .overCurrentContext
            itemVC.modalTransitionStyle = .crossDissolve
            itemVC.idHopDong = self.idHopDong
            itemVC.soHopDong = self.soHopDong
            self.present(itemVC, animated: true, completion: nil)
        case 2: //LichSuVayNo
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "LichSuViewController") as!LichSuViewController
            itemVC.code = 1
            itemVC.modalPresentationStyle = .overCurrentContext
            itemVC.modalTransitionStyle = .crossDissolve
            itemVC.idKhachHang = self.idKhachHang
            itemVC.tenKH = self.tenKhachHang
            self.present(itemVC, animated: true, completion: nil)
        case 0: //THU LAI
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "DongLaiViewController") as!DongLaiViewController
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
