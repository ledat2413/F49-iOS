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
    public var dataInfo: [CamDoChiTiet] = []
    
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()
        
        headerView.title = "Thông tin cầm đồ"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        tableView.register(UINib(nibName: "CheckBoxTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckBoxTableViewCell")
    }
    
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadInfo() {
        MGConnection.requestArray(APIRouter.GetChiTietCamDo(id: Int(id) ?? 0), CamDoChiTiet.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result{
                self.dataInfo = result
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ThongTinCamDoViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataInfo[indexPath.row]
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
            cell.keyLabel.text = "Họ và tên"
            cell.valueLabel.text = data.name
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
            cell.keyLabel.text = "Họ và tên"
            cell.valueLabel.text = data.name
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
            cell.keyLabel.text = "Họ và tên"
            cell.valueLabel.text = data.name
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else {fatalError()}
            cell.keyLabel.text = "Họ và tên"
            cell.valueLabel.text = data.name
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
    }
    
    
    
}
