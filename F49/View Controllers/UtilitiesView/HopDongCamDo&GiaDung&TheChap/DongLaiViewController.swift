//
//  DoiMatKhauViewController.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class DongLaiViewController: BaseController {
    
    //MARK: --Vars
    private var ngayHieuLucPicker: UIDatePicker?
    
    var idHopDong: Int = 0
    var ngayHieuLuc: String = ""
    
    var data: ChiTietHopDongThuLai?
    
    var selectedGiaoDich: String?
    var idLoaiGiaoDich: Int = 0
    
    var dataGiaoDich: [LoaiGiaoDich] = []
    var dataCTHĐTL: ChiTietHopDongThuLai?

    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var doButton: UIButton!
    
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.ngayHieuLuc = "\(Date.currentYear())-\(Date.currentMonth())-\(Date.currentDate())T\(00):\(00):\(00)"
        loadChiTietHopDongThuLai(ngayHieuLuc: self.ngayHieuLuc)
        self.hideKeyboardWhenTappedAround()

    }
    
    //MARK: --IBAction
    @IBAction func doButtonPressed(_ sender: Any) {
        putThuLai()
    }
    
    
    //MARK: --Function
    func loadCurrentDate(){
     
    }
    
    func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ThuLai3TableViewCell", bundle: nil), forCellReuseIdentifier: "ThuLai3TableViewCell")
        loadGiaoDich()
        navigation.title = "Thu lãi"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        
        doButton.backgroundColor = .gray
        
        doButton.displayTextField(radius: 20, color: UIColor.clear)
        buttonContainerView.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 20)
    }
    
    
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadChiTietHopDongThuLai(ngayHieuLuc: String){
        self.showActivityIndicator( view: self.view)

        MGConnection.requestObject(APIRouter.GetChiTietHopDongThuLai(idHopDong: idHopDong, ngayHieuLuc: ngayHieuLuc ), ChiTietHopDongThuLai.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else { return }
            if let result = result {
                self.dataCTHĐTL = result
                self.tableView.reloadData()
            }
        }
    }
    
    
    func loadGiaoDich(){
        MGConnection.requestArray(APIRouter.GetLoaiGiaoDich, LoaiGiaoDich.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataGiaoDich = result
            }
        }
    }
    
    
    func putThuLai(){
        self.showActivityIndicator( view: self.view)
        MGConnection.requestObject(APIRouter.PutThucHienThuLai(idHopDong: idHopDong, loaiGiaoDich: idLoaiGiaoDich, idCuaHangFormApp: dataCTHĐTL?.idCuaHang ?? 0, tienThucTe: Double(dataCTHĐTL?.phaiThu ?? 0) , ngayHieuLuc: self.ngayHieuLuc), ChiTietHopDongThuLai.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else {
                
                self.Alert("Đóng lãi không thành công!")
                print("Error: \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                
                return
                
            }
            self.handlerAlert(message: "Đóng lãi thành công") {
                NotificationCenter.default.post(name: NSNotification.Name.init("DongLai"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    // Date Picker
    func datePicker(textField: UITextField){
        ngayHieuLucPicker = UIDatePicker()
        ngayHieuLucPicker?.datePickerMode = .date

        if #available(iOS 13.4, *) {
            ngayHieuLucPicker?.preferredDatePickerStyle = .compact
        } else {
        }
        
        self.createDatePicker(picker: ngayHieuLucPicker!, selector: #selector(dateChange(ngayHieuLucPicker:)), textField: textField)
        self.createToolbar(textField: textField, selector: #selector(actionDate))
        
    }
    
    @objc func dateChange(ngayHieuLucPicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        ngayHieuLuc = dateFormatter.string(from: ngayHieuLucPicker.date)
        print(ngayHieuLuc)
        
    }
    
    @objc func actionDate(){
        loadChiTietHopDongThuLai(ngayHieuLuc: ngayHieuLuc)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    
    //Giao Dich Picker
    func createPickerView(tf: UITextField) {
        let pickerView = UIPickerView().createPicker(tf: tf)
        pickerView.delegate = self
        self.createToolbar(textField: tf, selector: #selector(action))
    }
    
    @objc func action() {
        self.doButton.isEnabled = true
        doButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        self.tableView.reloadData()
        view.endEditing(true)
    }
    
    
}

extension DongLaiViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height / 10)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThuLai3TableViewCell", for: indexPath) as? ThuLai3TableViewCell else { fatalError() }
        switch indexPath.row {
        case 0:

            cell.ui(keyString: "Số HĐ", valueString: dataCTHĐTL?.soHopDong ?? "Chưa rõ", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
            return cell
        case 1:
            
            cell.ui(keyString: "Tên KH", valueString: dataCTHĐTL?.tenKhachHang ?? "Chưa rõ", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
            
            return cell
        case 2:
            cell.ui(keyString: "Cửa hàng", valueString: dataCTHĐTL?.tenCuaHang ?? "Chưa rõ", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
            return cell
        case 3:
            
            cell.ui(keyString: "Số tiền vay", valueString: "\(dataCTHĐTL?.soTienVay ?? 0)", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
            return cell
            
        case 4:
            
            cell.ui(keyString: "Ngày hiệu lực", valueString: "", isHiddenTextField: false, isHiddenDownButton: true, isHiddenLichButton: false, numberPad: false)
            cell.valueLabel.isHidden = true
            
            cell.valueTextField.text = "\(Date.currentYear())/\(Date.currentMonth())/\(Date.currentDate())"
            
            let dateFormatOfString = DateFormatter()
            dateFormatOfString.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let dateFormatToString = DateFormatter()
            dateFormatToString.dateFormat = "yyyy/MM/dd"
            
            let date = dateFormatOfString.date(from: self.ngayHieuLuc)
                if let date = date {
                    cell.valueTextField.text = dateFormatToString.string(from: date)
                }
                datePicker(textField: cell.valueTextField)
                
            
            
            return cell
        case 5:
            cell.ui(keyString: "Giao dịch", valueString: "", isHiddenTextField: false, isHiddenDownButton: false, isHiddenLichButton: true, numberPad: false)
            cell.valueLabel.isHidden = true
            createPickerView(tf: cell.valueTextField)
            cell.valueTextField.text = selectedGiaoDich
            return cell
            
        case 6:
            cell.ui(keyString: "Nợ gốc", valueString: "\(dataCTHĐTL?.noGoc ?? 0)", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
            
            return cell
        case 7:
            cell.ui(keyString: "Nợ lãi", valueString: "\(dataCTHĐTL?.noLai ?? 0)", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
        
            return cell
        case 8:
            cell.ui(keyString: "Phải thu", valueString: "\(dataCTHĐTL?.phaiThu ?? 0)", isHiddenTextField: true, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: false)
    
            return cell
        case 9:
            cell.ui(keyString: "Thu thực tế", valueString: "", isHiddenTextField: false, isHiddenDownButton: true, isHiddenLichButton: true, numberPad: true)
            cell.valueLabel.isHidden = true
            
            cell.valueTextField.text = "\(dataCTHĐTL?.phaiThu ?? 0)"
            return cell
        default:    
            return UITableViewCell()
        }
    }
}

extension DongLaiViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataGiaoDich.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataGiaoDich[row].value
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGiaoDich = dataGiaoDich[row].value
        idLoaiGiaoDich = dataGiaoDich[row].id
    }
}


