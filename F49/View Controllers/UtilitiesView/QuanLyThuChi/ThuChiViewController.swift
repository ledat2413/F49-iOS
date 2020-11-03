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
    var idTienIch: Int = 0
    var dataCuaHang: [CuaHang] = []
    var dataThuChi: [ThuChi] = []
    var dataVon: [VonDauTu] = []
    var selectedCuaHang: String?
    var idShop: Int = 0
    
    private var fromPicker: UIDatePicker?
    private var toPicker: UIDatePicker?
    
    
    var fromValue: String?
    var toValue: String?
    
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
        
        datePicker()
        tableView.delegate = self
        tableView.dataSource = self
        
        switch idTienIch {
        case 5:
            tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
            break
        case 8:
            tableView.register(UINib(nibName: "RutVonTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonTableViewCell")
            break
        default:
            break
        }
        
        loadCuaHang()
        createPickerView()
        
        containerCuaHang.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 6)
        containerToday.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 6)
        containerFrom.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 6)
        containerTo.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 6)
        
        displayNavigation()
    }
    
    func displayNavigation() {
        switch idTienIch {
        case 5:
            navigation.title = "Quản lí thu chi"
            navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
            break
        case 8:
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
    
    func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(action))
    }
    
    
    @objc func action() {
        loadData()
        view.endEditing(true)
    }
    
    
    //DatePicker
    func datePicker(){
        
        fromPicker = UIDatePicker()
        toPicker = UIDatePicker()
        
        self.createToolbar(textField: fromTextField, selector: #selector(actionButton))
        self.createToolbar(textField: toTextField, selector: #selector(actionButton))
        self.createDatePicker(picker: toPicker! , selector: #selector(dateChanged(toPicker:)), textField: toTextField)
        self.createDatePicker(picker: fromPicker! , selector: #selector(dateChanged(fromPicker:)), textField: fromTextField)
        
    }
    
    
    @objc func dateChanged(fromPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        fromPicker.dateFormatte(txt: fromTextField)
        fromValue = dateFormatter.string(from: fromPicker.date)
        
        print(fromValue ?? "")
    }
    
    @objc func dateChanged(toPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        toPicker.dateFormatte(txt: toTextField)
        toValue = dateFormatter.string(from: toPicker.date)
        print(toValue ?? "")
    }
    
    @objc func actionButton(){
        loadData()
        view.endEditing(true)
    }
    
    
    func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
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
        
        if let fromValue = self.fromValue {
            params["dtTuNgay"] = fromValue
        }
        
        if let toValue = self.toValue {
            params["dtDenNgay"] = toValue
        }
        switch idTienIch {
        case 5:
            self.showSpinner(onView: self.view)
            MGConnection.requestArray(APIRouter.GetListThuChi(params: params), ThuChi.self) { (result, error) in
                self.removeSpinner()
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result {
                    self.dataThuChi = result
                    if result.count == 0 {
                        self.Alert("Không có dữ liếu")
                    }
                    self.tableView.reloadData()
                }
            }
            break
        case 8:
            self.showSpinner(onView: self.view)
            MGConnection.requestArray(APIRouter.GetListVonDauTu(params: params), VonDauTu.self) { (result, error) in
                self.removeSpinner()
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                    print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                    return
                }
                if let result = result {
                    self.dataVon = result
                    if result.count == 0 {
                        self.Alert("Không có dữ liếu")
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
        switch idTienIch {
        case 5:
            
            return  dataThuChi.count
        case 8:
            
            return dataVon.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch idTienIch {
            
        case 5:
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
        case 8:
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
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThongTinThuChiViewController") as! ThongTinThuChiViewController
        switch idTienIch {
        case 5:
            itemVC.idTienIch = idTienIch
            itemVC.id = dataThuChi[indexPath.row].id
            self.navigationController?.pushViewController(itemVC, animated: true)
        case 8:
            itemVC.idTienIch = idTienIch
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCuaHang = dataCuaHang[row].tenCuaHang
        shopTextField.text = selectedCuaHang
        idShop = dataCuaHang[row].id
    }
}
