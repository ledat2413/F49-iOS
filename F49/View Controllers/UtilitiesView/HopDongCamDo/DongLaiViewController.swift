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
    var ngayHieuLuc: String?
    
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
        loadChiTietHopDongThuLai()
        
    }
    
    //MARK: --IBAction
    @IBAction func doButtonPressed(_ sender: Any) {
        putThuLai()
    }
    
    
    //MARK: --Function
    func setUpUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ThuLai3TableViewCell", bundle: nil), forCellReuseIdentifier: "ThuLai3TableViewCell")
        loadGiaoDich()
        navigation.title = "Đóng lãi"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        doButton.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
        doButton.displayTextField(radius: 20, color: UIColor.clear)
        buttonContainerView.displayShadowView(shadowColor: UIColor.black, borderColor: UIColor.clear, radius: 20)
    }
    
    
    @objc func backView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadChiTietHopDongThuLai(){
        self.showSpinner(onView: self.view)
        MGConnection.requestObject(APIRouter.GetChiTietHopDongThuLai(idHopDong: idHopDong, ngayHieuLuc: ngayHieuLuc ?? ""), ChiTietHopDongThuLai.self) { (result, error) in
            self.removeSpinner()
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
        self.showSpinner(onView: self.view)
        MGConnection.requestObject(APIRouter.PutThucHienThuLai(idHopDong: idHopDong, loaiGiaoDich: idLoaiGiaoDich, idCuaHangFormApp: dataCTHĐTL?.idCuaHang ?? 0, tienThucTe: Double(dataCTHĐTL?.phaiThu ?? 0) , ngayHieuLuc: ngayHieuLuc ?? ""), ChiTietHopDongThuLai.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                self.Alert("Đóng lãi không thành công!")
                print("Error: \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                return }
             let alert = UIAlertController(title: "Thông Báo", message: "Đóng lãi thành công", preferredStyle: UIAlertController.Style.alert)
                   // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: self.popView))
                   
                   // show the alert
                   self.present(alert, animated: true, completion: nil)
           
        }
        
    }
    
    func popView(action: UIAlertAction){
        print("Pop View")
        NotificationCenter.default.post(name: NSNotification.Name.init("DongLai"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Date Picker
    func datePicker(textField: UITextField){
        ngayHieuLucPicker = UIDatePicker()
        ngayHieuLucPicker?.datePickerMode = .date
        textField.inputView = ngayHieuLucPicker
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(DongLaiViewController.dismissPicker))
        textField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        ngayHieuLuc = dateFormatter.string(from: ngayHieuLucPicker!.date)
        print(ngayHieuLuc!)
        loadChiTietHopDongThuLai()
        tableView.reloadData()
        view.endEditing(true)
    }
    
    //Giao Dich Picker
    func createPickerView(tf: UITextField) {
        let pickerView = UIPickerView().createPicker(tf: tf)
        pickerView.delegate = self
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(DongLaiViewController.action))
        tf.inputAccessoryView = toolBar
    }
    
    @objc func action() {
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
            cell.keyLabel.text = "Số HĐ"
            cell.valueLabel.text = dataCTHĐTL?.soHopDong ?? "Chưa rõ"
            return cell
        case 1:
            
            cell.keyLabel.text = "Tên KH"
            cell.valueLabel.text = dataCTHĐTL?.tenKhachHang ?? "Chưa rõ"
            
            return cell
        case 2:
            cell.keyLabel.text = "Cửa hàng"
            cell.valueLabel.text = dataCTHĐTL?.tenCuaHang ?? "Chưa rõ"
            return cell
        case 3:
            
            cell.keyLabel.text = "Số tiền vay"
            cell.valueLabel.text = "\(dataCTHĐTL?.soTienVay ?? 0)"
            return cell
            
        case 4:
            cell.keyLabel.text = "Ngày hiệu lực"
            
            cell.valueLabel.isHidden = true
            cell.iconDownButton.isHidden = true
            
            cell.valueTextField.isHidden = false
            cell.iconLichButton.isHidden = false
            
            let dateFormatOfString = DateFormatter()
            dateFormatOfString.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let dateFormatToString = DateFormatter()
            dateFormatToString.dateFormat = "yyyy/MM/dd"
            
            if let ngayHieuLuc = ngayHieuLuc {
                let date = dateFormatOfString.date(from: ngayHieuLuc)
                if let date = date {
                    cell.valueTextField.text = dateFormatToString.string(from: date)
                }
                datePicker(textField: cell.valueTextField)

            }
        
            return cell
        case 5:
            
            cell.keyLabel.text = "Giao dịch"
            
            cell.valueLabel.isHidden = true
            
            cell.valueTextField.isHidden = false
            cell.iconDownButton.isHidden = false
            
            createPickerView(tf: cell.valueTextField)
            cell.valueTextField.text = selectedGiaoDich
            return cell
            
        case 6:
            
            cell.keyLabel.text = "Nợ gốc"
            cell.valueLabel.text = "\(dataCTHĐTL?.noGoc ?? 0)"
            
            return cell
        case 7:
            
            cell.keyLabel.text = "Nợ lãi"
            cell.valueLabel.text = "\(dataCTHĐTL?.noLai ?? 0)"
            
            return cell
        case 8:
            
            cell.keyLabel.text = "Phải thu"
            cell.valueLabel.text = "\(dataCTHĐTL?.phaiThu ?? 0)"
            
            return cell
        case 9:
            cell.keyLabel.text = "Thu thực tế"
            cell.valueLabel.isHidden = true
            cell.valueTextField.isHidden = false
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
        self.tableView.reloadData()
    }
}


