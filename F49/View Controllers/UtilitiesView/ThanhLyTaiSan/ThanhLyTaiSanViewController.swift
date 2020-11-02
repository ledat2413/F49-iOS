//
//  ThanhLyTaiSanViewController.swift
//  F49
//
//  Created by Le Dat on 10/2/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThanhLyTaiSanViewController: BaseController {
    
    
    //MARK: --Vars
    var dataNhomTaiSan: [NhomTaiSan] = []
    var dataTenTaiSan: [TenTaiSan] = []
    var dataTabTrangThaiTaiSan: [TabTrangThaiTaiSan] = []
    var dataDSTaiSan: [DanhSachTaiSan] = []
    
    var idNhomVatCamDo: Int = 0
    var idTenVatCamDo: Int = 0
    var idTrangThaiTaiSan: Int = 0
    
    let pickerView = UIPickerView()
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    

    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var nhomTaiSanView: UIView!
    @IBOutlet weak var nhomTaiSanTextField: UITextField!
    
    @IBOutlet weak var tenTaiSanView: UIView!
    @IBOutlet weak var tenTaiSanTextField: UITextField!
    
    @IBOutlet weak var trangThaiView: UIView!
    @IBOutlet weak var trangThaiTextField: UITextField!
    
    //MARK: --View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUI()
    }
    
    // MARK: --Navigation
    func displayNavigation(){
        navigation.title = "Quản lí tài sản"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
        navigation.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
    }
    
    
    //MARK: --Func
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayUI() {
        displayTableView()
        displayNavigation()
        loadData()
        createPickerView()
        dismissPickerView()
    }
    
    func displayTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ThanhLyTaiSanTableViewCell", bundle: nil), forCellReuseIdentifier: "ThanhLyTaiSanTableViewCell")
    }
    
    func loadData(){
        loadNhomTaiSan()
        loadTabTrangThaiTaiSan()
    }
    
    func loadNhomTaiSan(){
        MGConnection.requestArray(APIRouter.GetDLNhomTaiSan, NhomTaiSan.self) { (result, error) in
            guard error == nil else {
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataNhomTaiSan = result
                self.nhomTaiSanTextField.text = result[0].tenNhom
            }
        }
    }
    
    func loadTenTaiSan(_ id: Int){
        MGConnection.requestArray(APIRouter.GetDLTenTaiSan(id: id), TenTaiSan.self) { (result, error) in
            guard error == nil else {
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataTenTaiSan = result
                self.tenTaiSanTextField.text = result[0].tenVatCamCo
            }
        }
    }
    
    func loadTabTrangThaiTaiSan(){
        MGConnection.requestArray(APIRouter.GetTabTrangThaiTaiSan, TabTrangThaiTaiSan.self) { (result, error) in
            guard error == nil else {
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataTabTrangThaiTaiSan = result
                self.trangThaiTextField.text = result[0].tenTrangThai
            }
        }
    }
    
    func loadTaiSan(idNhomVatCamDo: Int, idVatCamDo: Int, trangThai: Int){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetDLTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: idVatCamDo, trangThai: trangThai), DanhSachTaiSan.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataDSTaiSan = result
                self.tableView.reloadData()
            }
        }
    }
    
    func createPickerView() {
        
        pickerView.tag = 0
        pickerView1.tag = 1
        pickerView2.tag = 2
        
        pickerView1.delegate = self
        pickerView.delegate = self
        pickerView2.delegate = self
        
        trangThaiTextField.inputView = pickerView2
        nhomTaiSanTextField.inputView = pickerView
        tenTaiSanTextField.inputView = pickerView1
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        nhomTaiSanTextField.inputAccessoryView = toolBar
        tenTaiSanTextField.inputAccessoryView = toolBar
        trangThaiTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
}

extension ThanhLyTaiSanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThanhLyTaiSanChiTietViewController") as! ThanhLyTaiSanChiTietViewController
        itemVC.idTaiSan = dataDSTaiSan[indexPath.row].id
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataDSTaiSan.count != 0 {
            contentView.isHidden = true
        }
        return dataDSTaiSan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThanhLyTaiSanTableViewCell", for: indexPath) as? ThanhLyTaiSanTableViewCell else {fatalError()}
        
        let data = dataDSTaiSan[indexPath.row]
        
        cell.idLabel.text = "\(data.id)"
        cell.id2Label.text = "\(data.soHopDong)"
        cell.nameLabel.text = data.tenVatCamCo
        cell.dateLabel.text = data.ngayLuuKho
        cell.phoneLabel.text = data.dienThoai
        cell.customerLabel.text = data.hoTen
        
        return cell
    }
}

extension ThanhLyTaiSanViewController: UIPickerViewDataSource, UITextFieldDelegate, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return dataNhomTaiSan.count
        case 1:
            return dataTenTaiSan.count
        case 2:
            return dataTabTrangThaiTaiSan.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return dataNhomTaiSan[row].tenNhom
        case 1:
            return dataTenTaiSan[row].tenVatCamCo
        case 2:
            return dataTabTrangThaiTaiSan[row].tenTrangThai
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: //pickerLoaiTaiSan
            nhomTaiSanTextField.text = dataNhomTaiSan[row].tenNhom
            loadTenTaiSan(dataNhomTaiSan[row].id)
            idNhomVatCamDo = dataNhomTaiSan[row].id
            loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: idTenVatCamDo, trangThai: idTrangThaiTaiSan)

            break
        case 1: //pickerTenTaiSan
            tenTaiSanTextField.text = dataTenTaiSan[row].tenVatCamCo
            idTenVatCamDo = dataTenTaiSan[row].id
            print(idTenVatCamDo)
            loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: idTenVatCamDo, trangThai: idTrangThaiTaiSan)

            break
        case 2:
            trangThaiTextField.text = dataTabTrangThaiTaiSan[row].tenTrangThai
            idTrangThaiTaiSan = dataTabTrangThaiTaiSan[row].id
            print(idTrangThaiTaiSan)
            loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: idTenVatCamDo, trangThai: idTrangThaiTaiSan)
            break
        default:
            break
        }
    }
}
