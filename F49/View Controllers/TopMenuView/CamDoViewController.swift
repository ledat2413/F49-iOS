//
//  CamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CamDoViewController: UIViewController {
    
    //MARK: --Vars
    var key: String = ""
    var dataStatus: [Status] = []
    var dataListCamDo: [CamDo] = []
    var dataListDinhGia: [DinhGia] = []
    var dataListDoGiaDung: [DoGiaDung] = []
    var selectedStatus: String?
    
    //MARK: --IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayTitle()
        loadStatus()
        createPickerView()
        dismissPickerView()
        
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "CamDoTableViewCell")
    }
    
    //MARK: --Func
    
    private func displayTitle(){
        switch key {
        case "A":
            return headerView.title = "Cầm Đồ"
            
        case "B":
            return headerView.title = "Định Giá"
            
        case "C":
            return headerView.title = "Đồ Gia dụng"
            
        default:
            break
        }
    }
    
    private func loadData(id: String){
        switch key {
        case "A":
            MGConnection.requestArray(APIRouter.GetListCamDo(id: id), CamDo.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataListCamDo = result
                    self.tableView.reloadData()
                }
            }
            break
        case "B":
            MGConnection.requestArray(APIRouter.GetListDinhGia(id: id), DinhGia.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataListDinhGia = result
                    self.tableView.reloadData()
                }
            }
            break
        case "C":
            MGConnection.requestArray(APIRouter.GetListDoGiaDung(id: id), DoGiaDung.self) { (result, error) in
                guard error == nil else {
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result{
                    self.dataListDoGiaDung = result
                    self.tableView.reloadData()
                }
            }
            break
        default:
            break
        }
    }
    
    private func loadStatus(){
        MGConnection.requestArray(APIRouter.GetStatus, Status.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result{
                self.dataStatus = result
            }
        }
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        findTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        findTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}

extension CamDoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch key {
        case "A":
            return dataListCamDo.count
        case "B":
            return dataListDinhGia.count
        case "C":
            return dataListDoGiaDung.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamDoTableViewCell", for: indexPath) as? CamDoTableViewCell else {
            fatalError()}
//        if dataStatus[indexPath.row].id == "1" {
//            cell.statusImage.image = UIImage(named: "icon-dangxuly")
//        }else{
//            cell.statusImage.isHidden = true
//        }
        
        switch key {
        case "A":
            let data = dataListCamDo[indexPath.row]
            cell.idLabel.text = data.id
            cell.nameLabel.text = data.name
            cell.birthDateLabel.text = data.date
            cell.numberPhoneLabel.text = data.phone
            cell.nameItemLabel.text = data.brand
            cell.subItemLabel.text = "Nhãn hiệu"
            cell.subItemImage.image = UIImage(named: "icon-content-nhanhang")
            
            break
        case "B":
            let data = dataListDinhGia[indexPath.row]
            cell.idLabel.text = data.id
            cell.nameLabel.text = data.name
            cell.birthDateLabel.text = data.regDate
            cell.numberPhoneLabel.text = data.phone
            cell.nameItemLabel.text = data.email
            cell.subItemLabel.text = "Họ và tên"
            cell.subItemImage.image = UIImage(named: "icon-content-nhanvien")
            
            break
        case "C":
            let data = dataListDoGiaDung[indexPath.row]
            cell.idLabel.text = data.id
            cell.nameLabel.text = data.name
            cell.birthDateLabel.text = data.date
            cell.numberPhoneLabel.text = data.phone
            cell.nameItemLabel.text = data.asset
            cell.subItemLabel.text = "Tài sản"
            cell.subItemImage.image = UIImage(named: "icon-content-taisan")
            
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThongTinCamDoViewController") as! ThongTinCamDoViewController
        itemVC.id = dataListCamDo[indexPath.row].id
        self.present(itemVC, animated: true, completion: nil)
    }
    
}

extension CamDoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataStatus.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataStatus[row].value
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStatus = dataStatus[row].value
        loadData(id: dataStatus[row].id)
        findTextField.text = selectedStatus
    }
}
