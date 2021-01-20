//
//  BaoCaoViewController.swift
//  F49
//
//  Created by Le Dat on 10/6/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class BaoCaoViewController: BaseController {
    
    
    //MARK: --Vars
    
    fileprivate var fromPicker: UIDatePicker?
    fileprivate var toPicker: UIDatePicker?
    
    fileprivate let toolBar = UIToolbar()
    
    fileprivate var dataCuaHang: [CuaHang] = []
    fileprivate var dataBaoCao: BaoCaoTongHop?
    
    var selectedCuaHang: String?
    var fromValue: String?
    var toValue: String?
    
    var id: Int = 0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromTextField: UITextField!
    
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        displayTableView()
        datePicker()
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: --Func
    
    
    fileprivate func displayTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        tableView.register(UINib(nibName: "TacVuTableViewCell", bundle: nil), forCellReuseIdentifier: "TacVuTableViewCell")
        
        loadCuaHang()
        loadBaoCao()
        
        createPickerView()
        
        navigation.title = "Báo cáo tổng hợp"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        
        shopContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        fromView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        toView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        self.fromTextField.text = "\(01)/\(Date.currentMonth())/\(Date.currentYear())"
        self.toTextField.text = "\(Date.currentDate())/\(Date.currentMonth())/\(Date.currentYear())"
        self.fromValue = "\(Date.currentYear())-\(Date.currentMonth())-\(01)'T'\(00):\(00):\(00)"
        self.toValue = "\(Date.currentYear())-\(Date.currentMonth())-\(Date.currentDate())'T'\(00):\(00):\(00)"
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //Load Cua Hang
    fileprivate func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")

                return
                
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = result[0].tenCuaHang
                
            }
        }
    }
    
    
    //Load Bao Cao
    fileprivate func loadBaoCao(){
        var params: [String: Any] = ["idCuaHang": id]
        
        if let fromValue = fromValue {
            params["dtTuNgay"] = fromValue
        }
        if let toValue = toValue {
            params["dtDenNgay"] = toValue
        }
        
        self.showActivityIndicator( view: self.view)

        MGConnection.requestObject(APIRouter.GetBaoCaoTongHop(params: params), BaoCaoTongHop.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")

                return }
            if let result = result {
                self.dataBaoCao = result
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    //DatePicker
    fileprivate func datePicker(){
        
        fromPicker = UIDatePicker()
        toPicker = UIDatePicker()
        
        self.createDatePicker(picker: fromPicker!, selector: #selector(dateChanged(fromPicker:)), textField: fromTextField)
        self.createDatePicker(picker: toPicker!, selector: #selector(dateChanged(toPicker:)), textField: toTextField)
        self.createToolbar(textField: fromTextField, selector: #selector(doneButton))
        self.createToolbar(textField: toTextField, selector: #selector(doneButton))
        
      
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
    
    
    @objc func doneButton(){
        loadBaoCao()
        view.endEditing(true)
        
    }
    
    //PickerView
    fileprivate func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(action))
    }
    
    @objc func action() {
        loadBaoCao()
        view.endEditing(true)
    }
    
}

extension BaoCaoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 6
        default:
            return 3
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TacVuTableViewCell") as? TacVuTableViewCell else { fatalError() }
            cell.titleLabel.text = "Tiền đầu kì"
            cell.titleLabel.textColor = .systemGreen
            cell.backgroundColor = UIColor.white
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TacVuTableViewCell") as? TacVuTableViewCell else { fatalError() }
            cell.titleLabel.text = "Tiền cuối kì"
            cell.titleLabel.textColor = .systemGreen
            cell.backgroundColor = UIColor.white
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TacVuTableViewCell") as? TacVuTableViewCell else { fatalError() }
            cell.titleLabel.text = "Biến động trong kì"
            cell.titleLabel.textColor = .systemGreen
            cell.backgroundColor = UIColor.white
            
            return cell
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Tiền mặt"
                cell.valueLabel.text = dataBaoCao?.tienMatDauKy
            case 1:
                cell.keyLabel.text = "Dư nợ"
                cell.valueLabel.text = dataBaoCao?.duNoDauKy
            case 2:
                cell.keyLabel.text = "Thanh lý"
                cell.valueLabel.text = dataBaoCao?.thanhLyDauKy
                
            default:
                return cell
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Tiền mặt"
                cell.valueLabel.text = dataBaoCao?.tienMatCuoiKy
            case 1:
                cell.keyLabel.text = "Dư nợ"
                cell.valueLabel.text = dataBaoCao?.duNoCuoiKy
            case 2:
                cell.keyLabel.text = "Thanh lý"
                cell.valueLabel.text = dataBaoCao?.thanhLyCuoiKy
            default:
                return cell
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Đầu tư - rút vốn"
                cell.valueLabel.text = dataBaoCao?.dauTuRutVon
            case 1:
                cell.keyLabel.text = "Vốn vay ngoài"
                cell.valueLabel.text = dataBaoCao?.vonVayNgoai
            case 2:
                cell.keyLabel.text = "Vốn cho vay"
                cell.valueLabel.text = dataBaoCao?.vonChoVay
            case 3:
                cell.keyLabel.text = "Vốn thu về từ hợp đồng"
                cell.valueLabel.text = dataBaoCao?.vonThuVeTuHD
            case 4:
                cell.keyLabel.text = "Lãi, lệ phí thu được"
                cell.valueLabel.text = dataBaoCao?.laiThuDuoc
            case 5:
                cell.keyLabel.text = "Tăng giảm thanh lý"
                cell.valueLabel.text = dataBaoCao?.tangGiamThanhLy
            case 6:
                cell.keyLabel.text = "Cân đối thu chi"
                cell.valueLabel.text = dataBaoCao?.canDoiThuChi
                
            default:
                return cell
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension BaoCaoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        id = dataCuaHang[row].id
        shopTextField.text = selectedCuaHang
    }
}
