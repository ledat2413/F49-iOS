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
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    

    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        self.hideKeyboardWhenTappedAround()

    }
    
    
    
    // MARK: --Navigation
    func displayNavigation(){
        navigation.title = "Quản lí tài sản"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
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
        nhomTaiSanView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
        tenTaiSanView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
        trangThaiView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
    }
    
    
    
    func displayTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ThanhLyTaiSanTableViewCell", bundle: nil), forCellReuseIdentifier: "ThanhLyTaiSanTableViewCell")
        tableView.register(UINib(nibName: "ErrTableViewCell", bundle: nil), forCellReuseIdentifier: "ErrTableViewCell")
    }
    
    
    
    func loadData(){
        loadNhomTaiSan()
        loadTabTrangThaiTaiSan()
    }
    
    
    
    func loadNhomTaiSan(){
        MGConnection.requestArray(APIRouter.GetDLNhomTaiSan, NhomTaiSan.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại")
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataNhomTaiSan = result
                self.nhomTaiSanTextField.text = result[0].tenNhom
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
            }
        }
    }
    
    
    
    func loadTenTaiSan(_ id: Int){
        MGConnection.requestArray(APIRouter.GetDLTenTaiSan(id: id), TenTaiSan.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại")
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataTenTaiSan = result
                self.tenTaiSanTextField.text = result[0].tenVatCamCo
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
            }
        }
    }
    
    
    
    func loadTabTrangThaiTaiSan(){
        MGConnection.requestArray(APIRouter.GetTabTrangThaiTaiSan, TabTrangThaiTaiSan.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại")
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataTabTrangThaiTaiSan = result
                self.trangThaiTextField.text = result[0].tenTrangThai
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
            }
        }
    }
    
    
    
    func loadTaiSan(idNhomVatCamDo: Int, idVatCamDo: Int, trangThai: Int){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetDLTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: idVatCamDo, trangThai: trangThai), DanhSachTaiSan.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại")
                print("Error : \(error?.mErrorMessage ?? "") and code : \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataDSTaiSan = result
                print(result.count)
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
                self.tableView.reloadData()

            }
        }
    }
    
    
    
    func createPickerView() {
        
        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        
        pickerView1.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        
        nhomTaiSanTextField.inputView = pickerView1
        tenTaiSanTextField.inputView = pickerView2
        trangThaiTextField.inputView = pickerView3
        
        self.createToolbar(textField: nhomTaiSanTextField, selector: #selector(actionNhomTaiSan))
        self.createToolbar(textField: tenTaiSanTextField, selector: #selector(actionTenTaiSan))
        self.createToolbar(textField: trangThaiTextField, selector: #selector(actionTrangThaiTaiSan))

    }
    
    
    @objc func actionTrangThaiTaiSan() {
        loadTabTrangThaiTaiSan()
        self.loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: self.idTenVatCamDo, trangThai: self.idTrangThaiTaiSan)
        view.endEditing(true)
    }
    
    @objc func actionNhomTaiSan(){
        loadTenTaiSan(idNhomVatCamDo)
        self.loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: self.idTenVatCamDo, trangThai: self.idTrangThaiTaiSan)
        view.endEditing(true)
    }
    
    @objc func actionTenTaiSan(){
        self.loadTaiSan(idNhomVatCamDo: idNhomVatCamDo, idVatCamDo: self.idTenVatCamDo, trangThai: self.idTrangThaiTaiSan)
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
        case 1:
            return dataNhomTaiSan.count
        case 2:
            return dataTenTaiSan.count
        case 3:
            return dataTabTrangThaiTaiSan.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return dataNhomTaiSan[row].tenNhom
        case 2:
            return dataTenTaiSan[row].tenVatCamCo
        case 3:
            return dataTabTrangThaiTaiSan[row].tenTrangThai
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1: //pickerLoaiTaiSan
            nhomTaiSanTextField.text = dataNhomTaiSan[row].tenNhom
            idNhomVatCamDo = dataNhomTaiSan[row].id
            break
        case 2: //pickerTenTaiSan
            tenTaiSanTextField.text = dataTenTaiSan[row].tenVatCamCo
            idTenVatCamDo = dataTenTaiSan[row].id
            print(idTenVatCamDo)
            break
        case 3:
            trangThaiTextField.text = dataTabTrangThaiTaiSan[row].tenTrangThai
            idTrangThaiTaiSan = dataTabTrangThaiTaiSan[row].id
            print(idTrangThaiTaiSan)
            break
        default:
            break
        }
    }
}
