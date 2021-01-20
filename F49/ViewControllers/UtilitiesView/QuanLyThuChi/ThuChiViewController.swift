//
//  ThuChiViewController.swift
//  F49
//
//  Created by Le Dat on 9/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class ThuChiViewController: BaseController {
    
    //MARK: --Vars
    var screenID: String = ""
    fileprivate var dataCuaHang: [CuaHang] = []
    fileprivate var dataThuChi: [ThuChi] = []
    fileprivate var dataVon: [VonDauTu] = []
    var selectedCuaHang: String?
    var idShop: Int = 0
    var pickerView: UIPickerView?
    
    private var fromPicker: UIDatePicker?
    private var toPicker: UIDatePicker?
    private var todayPicker: UIDatePicker?
    
    var fromValue: String?
    var toValue: String?
    
    let dateFormatter = DateFormatter()
    
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
        hideKeyboardWhenTappedAround()
        
    }
    
    //MARK: --Func
    
    fileprivate func setUpUI(){
        self.fromValue = "\(Date.currentYear())-\(Date.currentMonth())-\(01)'T'\(00):\(00):\(00)"
        self.toValue = "\(Date.currentYear())-\(Date.currentMonth())-\(Date.currentDate())'T'\(00):\(00):\(00)"
        
        datePicker()
        shopTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        switch screenID {
        case "ThuChi":
            tableView.register(UINib(nibName: "RutVonTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonTableViewCell")
            break
        case "RutVon":
            tableView.register(UINib(nibName: "RutVonTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonTableViewCell")
            break
        default:
            break
        }
        
        loadCuaHang()
        createPickerView()
        
        self.fromTextField.text = "\(01)/\(Date.currentMonth())/\(Date.currentYear())"
        self.toTextField.text = "\(Date.currentDate())/\(Date.currentMonth())/\(Date.currentYear())"
        
        
        containerCuaHang.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 6)
        containerToday.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 6)
        containerFrom.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 6)
        containerTo.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 6)
        
        displayNavigation()
        
        
    }
    
    fileprivate func displayNavigation() {
        switch screenID {
        case "ThuChi":
            navigation.title = "Quản lí thu chi"
            navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
            break
        case "RutVon":
            navigation.title = "Rút vốn"
            navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
            break
        default:
            break
        }
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func createPickerView() {
        pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView?.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(action))
    }
    
    
    @objc func action() {
        loadData()
        view.endEditing(true)
    }
    
    
    //DatePicker
    fileprivate func datePicker(){
        
        fromPicker = UIDatePicker()
        toPicker = UIDatePicker()
        todayPicker = UIDatePicker()
        self.createToolbar(textField: fromTextField, selector: #selector(actionButton))
        self.createToolbar(textField: toTextField, selector: #selector(actionButton))
        self.createToolbar(textField: toDayTextField, selector: #selector(actionButton))
        self.createDatePicker(picker: toPicker! , selector: #selector(dateChanged(toPicker:)), textField: toTextField)
        self.createDatePicker(picker: fromPicker! , selector: #selector(dateChanged(fromPicker:)), textField: fromTextField)
        //        self.createDatePicker(picker: todayPicker!, selector: #selector(date), textField: UITextField)
        
    }
    
    
    @objc func dateChanged(fromPicker: UIDatePicker){
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        fromPicker.dateFormatte(txt: fromTextField)
        fromValue = dateFormatter.string(from: fromPicker.date)
        
        print(fromValue ?? "")
    }
    
    @objc func dateChanged(toPicker: UIDatePicker){
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        toPicker.dateFormatte(txt: toTextField)
        toValue = dateFormatter.string(from: toPicker.date)
        print(toValue ?? "")
    }
    
    @objc func actionButton(){
        loadData()
        view.endEditing(true)
    }
    
    
    fileprivate func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                return
            }
            if let result = result {
                self.dataCuaHang = result
            }
        }
    }
    
    fileprivate func loadData() {
        
        var params: [String: Any] = ["idCuaHang": idShop]
        
        if let fromValue = self.fromValue {
            params["dtTuNgay"] = fromValue
        }
        
        if let toValue = self.toValue {
            params["dtDenNgay"] = toValue
        }
        switch screenID {
        case "ThuChi":
            self.showActivityIndicator( view: self.view)
            
            MGConnection.requestArray(APIRouter.GetListThuChi(params: params), ThuChi.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    return
                }
                if let result = result {
                    self.dataThuChi = result
                    if result.count == 0 {
                        self.Alert("Không có dữ liệu")
                    }
                    self.tableView.reloadData()
                }
            }
            break
            
        case "RutVon":
            self.showActivityIndicator( view: self.view)
            
            MGConnection.requestArray(APIRouter.GetListVonDauTu(params: params), VonDauTu.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    return
                }
                if let result = result {
                    self.dataVon = result
                    if result.count == 0 {
                        self.Alert("Không có dữ liệu")
                    }
                    self.tableView.reloadData()
                }
            }
        default:
            break
        }
        
    }
}

extension ThuChiViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch screenID {
        case "ThuChi":
            return  dataThuChi.count
        case "RutVon":
            return dataVon.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch screenID {
        
        case "ThuChi":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVonTableViewCell", for: indexPath) as? RutVonTableViewCell else {fatalError()}
            let data = dataThuChi[indexPath.row]
            
            cell.header1Label.text = "Thu"
            cell.header2Label.text = "Chi"
            cell.header3Label.text = "Người thực hiện"
            cell.header2ImageView.image = UIImage(named: "icon-content-tien")
            
            cell.idLabel.text = "\(data.id)"
            cell.nameLabel.text = data.tenCuaHang
            cell.moneyLabel.text = data.thu
            cell.dateLabel.text = data.chi
            cell.peopleLabel.text = data.nguoiThucHien
            
            return cell
        case "RutVon":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVonTableViewCell", for: indexPath) as? RutVonTableViewCell else {fatalError()}
            let data = dataVon[indexPath.row]
            cell.idLabel.text = "\(data.idCuaHang)"
            cell.nameLabel.text = data.tenCuaHang
            cell.dateLabel.text = data.ngayGiaoDich
            cell.moneyLabel.text = "\(data.soTien)"
            cell.peopleLabel.text = data.nguoiThucHien
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "THUCHI", bundle: nil).instantiateViewController(withIdentifier: "ThongTinThuChiViewController") as! ThongTinThuChiViewController
        switch screenID {
        case "ThuChi":
            itemVC.screenID = screenID
            itemVC.id = dataThuChi[indexPath.row].id
            self.navigationController?.pushViewController(itemVC, animated: true)
        case "RutVon":
            itemVC.screenID = screenID
            itemVC.id = dataVon[indexPath.row].idItem
            self.navigationController?.pushViewController(itemVC, animated: true)
        default:
            break
        }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == shopTextField{
            self.pickerView?.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView!, didSelectRow: 0, inComponent: 0)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCuaHang = dataCuaHang[row].tenCuaHang
        shopTextField.text = selectedCuaHang
        idShop = dataCuaHang[row].id
    }
}
