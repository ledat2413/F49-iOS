//
//  ChiTietHopDongViewController.swift
//  F49
//
//  Created by Le Dat on 9/24/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ChiTietHopDongViewController: BaseController {
    
    //MARK: --Vars
    var id: Int = 0
    var dataChiTiet: ChiTietHopDong?
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        loadData()
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        navigation.title = "Thông tin hợp đồng cầm đồ"
        
    }
    
    
    //MARK: --Func
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadData(){
        self.showSpinner(onView: self.view)
        MGConnection.requestObject(APIRouter.GetChiTietHopDong(id: id), ChiTietHopDong.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataChiTiet = result
                self.tableView.reloadData()
            }
        }
    }
}

extension ChiTietHopDongViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((self.tableView.frame.height)/13)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Số HĐ"
            cell.valueLabel.text = dataChiTiet?.numberContract ?? ""
            return cell
        case 1:
            cell.keyLabel.text = "Tên KH"
            cell.valueLabel.text = dataChiTiet?.fullName ?? ""
            return cell
        case 2:
            cell.keyLabel.text = "Điện thoại"
            cell.valueLabel.text = dataChiTiet?.phoneNumber ?? ""
            return cell
        case 3:
            cell.keyLabel.text = "Dư nợ"
            cell.valueLabel.text = dataChiTiet?.duNo ?? ""
            return cell
        case 4:
            cell.keyLabel.text = "Ngày đến hạn"
            cell.valueLabel.text = dataChiTiet?.appointmentDate ?? ""
            return cell
        case 5:
            cell.keyLabel.text = "+/-"
            cell.valueLabel.text = "\(dataChiTiet?.plusMin ?? 0)"
            return cell
            
        case 6:
            cell.keyLabel.text = "Lãi"
            cell.valueLabel.text = dataChiTiet?.interest ?? ""
            return cell
        case 7:
            cell.keyLabel.text = "Phí"
            cell.valueLabel.text = dataChiTiet?.fee ?? ""
            return cell
        case 8:
            cell.keyLabel.text = "Tổng"
            cell.valueLabel.text = dataChiTiet?.total ?? ""
            return cell
        case 9:
            cell.keyLabel.text = "Nhắc nợ"
            cell.valueLabel.text = dataChiTiet?.ngayNhacNho ?? ""
            return cell
        case 10:
            cell.keyLabel.text = "Ngày hẹn"
            cell.valueLabel.text = dataChiTiet?.expiredDate ?? ""
            return cell
        case 11:
            cell.keyLabel.text = "Nội dung"
            cell.valueLabel.text = dataChiTiet?.content ?? ""
            return cell
        case 12:
            cell.keyLabel.text = "Đồ để lại"
            cell.valueLabel.text = dataChiTiet?.doDeLai ?? ""
            return cell
        default:
            return cell
        }
    }
}
