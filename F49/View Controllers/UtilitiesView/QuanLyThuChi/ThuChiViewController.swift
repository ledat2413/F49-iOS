//
//  ThuChiViewController.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThuChiViewController: UIViewController {
    
    //MARK: --Vars
    var dataCuaHang: [CuaHang] = []
    var dataThuChi: [ThuChi] = []
    var selectedCuaHang: String?
    var idShop: Int = 0
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var containerCuaHang: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    @IBOutlet weak var containerToday: UIView!
    @IBOutlet weak var toDayTextField: UITextField!
    
    @IBOutlet weak var containerFrom: UIView!
    @IBOutlet weak var fromTextField: UITextField!
    
    @IBOutlet weak var containerTo: UIView!
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --IBAction
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: --Func
    
    func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
        loadCuaHang()
        createPickerView()
        dismissPickerView()
        displayShadowView(containerCuaHang)
        displayShadowView(containerToday)
        displayShadowView(containerFrom)
        displayShadowView(containerTo)
        displayNavigation()
    }
    
    func displayNavigation() {
        navigation.title = "Quản lí thu chi"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 6
    }
    
    func cornerRadius(_ view: UIView){
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        shopTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        shopTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataCuaHang = result
            }
        }
    }
    
    func loadData() {
        var params: [String: Any] = ["idCuaHang": idShop]
        
        //              if let toDate = self.idStatus {
        //                  params["dtTuNgay"] = toDate
        //              }
        
        //        if let fromDate = self.fromDate {
        //            params["dtDenNgay"] = fromDate
        //
        //        }
        MGConnection.requestArray(APIRouter.GetListThuChi(params: params), ThuChi.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataThuChi = result
                self.tableView.reloadData()
            }
        }
    }
}

extension ThuChiViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataThuChi.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else {fatalError()}
        
        let data = dataThuChi[indexPath.row]
        cell.icon1ImageView.image = UIImage(named: "icon-content-tien")
        cell.icon2ImageView.image = UIImage(named: "icon-content-tien")
        cell.icon3Imageview.image = UIImage(named: "icon-content-nhanvien")
        
        cell.title1Label.text = "Thu"
        cell.title2Label.text = "Chi"
        cell.title3Label.text = "Người thực hiện"
        
        cell.tangGiamLabel.text = data.thu
        cell.tienLabel.text = data.chi
        cell.tongLabel.text = data.nguoiThucHien
        cell.idLabel.text = "\(data.id)"
        cell.id2Label.text = data.tenCuaHang
        cell.nameLabel.isHidden = true
        cell.betweenLabel.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThongTinThuChiViewController") as! ThongTinThuChiViewController
        itemVC.id = dataThuChi[indexPath.row].id
        self.navigationController?.pushViewController(itemVC, animated: true)
        
    }
}

extension ThuChiViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataCuaHang.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataCuaHang[row].tenCuaHang
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCuaHang = dataCuaHang[row].tenCuaHang
        shopTextField.text = selectedCuaHang
        idShop = dataCuaHang[row].id
        loadData()
    }
}
