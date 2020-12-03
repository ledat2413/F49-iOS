//
//  CamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CamDoViewController: BaseController {
    
    //MARK: --Vars
    var index: Int = 0
    fileprivate var dataStatus: [Status] = []
    fileprivate var dataListCamDo: [CamDo] = []
    fileprivate var dataListDinhGia: [DinhGia] = []
    fileprivate var dataListDoGiaDung: [DoGiaDung] = []
    var selectedStatus: String?
    var callBack: ((_ index: Int) -> Void)?
    
    
    
    //MARK: --IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData(trangThai: "1")

        displayTitle()
        loadStatus()
        createPickerView()
        self.hideKeyboardWhenTappedAround()
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        containerView.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 6)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "CamDoTableViewCell")
    }
    
    //MARK: --Func
    
    fileprivate func displayTitle(){
        switch index {
        case 0:
            return headerView.title = "Cầm Đồ"
        case 1:
            return headerView.title = "Định Giá"
        case 2:
            return headerView.title = "Đồ Gia dụng"
        default:
            break
        }
    }
    
    fileprivate func loadData(trangThai: String){
        switch index {
        case 0:
            MGConnection.requestArray(APIRouter.GetListCamDo(trangThai: trangThai), CamDo.self) { (result, error) in
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                                        return
                }
                if result!.count == 0 {
                    self.Alert("Có lỗi xảy ra")
                }
                if let result = result{
                    self.dataListCamDo = result

                    self.tableView.reloadData()
                }
            }
            break
            
        case 1:
            MGConnection.requestArray(APIRouter.GetListDinhGia(trangThai: trangThai), DinhGia.self) { (result, error) in
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    
                    return
                }
                if result?.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
                if let result = result{
                    self.dataListDinhGia = result

                    self.tableView.reloadData()
                }
            }
            break
            
        case 2:
            MGConnection.requestArray(APIRouter.GetListDoGiaDung(trangThai: trangThai), DoGiaDung.self) { (result, error) in
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    
                    return
                }
                if result?.count == 0 {
                    self.Alert("Không có dữ liệu")
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
    
    fileprivate func loadStatus(){
        MGConnection.requestArray(APIRouter.GetStatus, Status.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result{
                self.dataStatus = result
                self.findTextField.text = result[1].value

            }
        }
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        findTextField.inputView = pickerView
        self.createToolbar(textField: findTextField, selector: #selector(action))
    }
    
    @objc func action() {
        loadData(trangThai: selectedStatus ?? "")
        view.endEditing(true)
    }
}

extension CamDoViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch index {
        case 0:
            
            return dataListCamDo.count
        case 1:
            
            return dataListDinhGia.count
        case 2:
            
            return dataListDoGiaDung.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamDoTableViewCell", for: indexPath) as? CamDoTableViewCell else {
            fatalError()}
        if dataStatus[indexPath.row].id == "1" {
            cell.statusImage.image = UIImage(named: "icon-dangxuly")
        }else{
            cell.statusImage.isHidden = true
        }
        
        switch index {
        case 0:
            let data = dataListCamDo[indexPath.row]
            cell.idLabel.text = data.id
            cell.nameLabel.text = data.name
            cell.birthDateLabel.text = data.date
            cell.numberPhoneLabel.text = data.phone
            cell.nameItemLabel.text = data.brand
            cell.subItemLabel.text = "Nhãn hiệu"
            cell.subItemImage.image = UIImage(named: "icon-content-nhanhang")
            
            break
        case 1:
            let data = dataListDinhGia[indexPath.row]
            cell.idLabel.text = data.id
            cell.nameLabel.text = data.name
            cell.birthDateLabel.text = data.regDate
            cell.numberPhoneLabel.text = data.phone
            cell.nameItemLabel.text = data.email
            cell.subItemLabel.text = "Họ và tên"
            cell.subItemImage.image = UIImage(named: "icon-content-nhanvien")
            
            break
        case 2:
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
        
        switch index {
        case 0:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThongTinCamDoViewController") as! ThongTinCamDoViewController
            itemVC.id = dataListCamDo[indexPath.row].id
            itemVC.index = index
            print(index)
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        case 1:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThongTinCamDoViewController") as! ThongTinCamDoViewController
            itemVC.id = dataListDinhGia[indexPath.row].id
            itemVC.index = index
            print(index)
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        case 2:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThongTinCamDoViewController") as! ThongTinCamDoViewController
            itemVC.id = dataListDoGiaDung[indexPath.row].id
            itemVC.index = index
            print(index)
            self.navigationController?.pushViewController(itemVC, animated: true)
        default:
            break
        }
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
        findTextField.text = selectedStatus
    }
}
