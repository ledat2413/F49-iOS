//
//  TienHoaHongViewController.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class TienHoaHongViewController: BaseController {
    
    //MARK: --Vars
    var selectedNhanVien: String?
    var dataTienHoaHong: [NhanVien] = []
    var dataNhanVien: [NhanVien] = []
    
    var idNhanVien: Int = 0
    var string: String?
    
    private var fromPicker: UIDatePicker?
    private var toPicker: UIDatePicker?
    
    var fromValue: String?
    var toValue: String?
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    @IBOutlet weak var fromContainerView: UIView!
    @IBOutlet weak var fromTextField: UITextField!
    
    @IBOutlet weak var toContainerView: UIView!
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()   
        // Do any additional setup after loading the view.
    }
    
    //MARK: --Func
    func setUpUI() {
        displayNavigation()
        shopContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        toContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        fromContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 5)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderTienHoaHongTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTienHoaHongTableViewCell")
        tableView.register(UINib(nibName: "BodyTienHoaHongTableViewCell", bundle: nil), forCellReuseIdentifier: "BodyTienHoaHongTableViewCell")
        loadNhanVien()
        createPickerView()
        datePicker()
    }
    
    func loadNhanVien(){
        MGConnection.requestArray(APIRouter.GetDanhSachNhanVien, NhanVien.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                return
                
            }
            if let result = result {
                self.dataNhanVien = result
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func loadTableView(){
        
        var params: [String: Any] = ["idNhanVien" : idNhanVien ]
        
        if let fromValue = self.fromValue {
            params["tuNgay"] = fromValue
        }
        
        if let toValue = self.toValue {
            params["denNgay"] = toValue
        }
        
        MGConnection.requestArray(APIRouter.GetTienHoaHong(params: params), NhanVien.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                
                return }
            if let result = result{
                self.dataTienHoaHong = result
                if result.count == 0 {
                    self.Alert("Không có dữ liệu")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func displayNavigation(){
        navigation.title = "Tiền hoa hồng"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        shopTextField.inputView = pickerView
        self.createToolbar(textField: shopTextField, selector: #selector(action))
    }
    
    
    @objc func action() {
        loadTableView()
        view.endEditing(true)
    }
    
    func datePicker(){
        
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
        loadTableView()
        view.endEditing(true)
        
    }
    
}
extension TienHoaHongViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataTienHoaHong.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTienHoaHongTableViewCell", for: indexPath) as? HeaderTienHoaHongTableViewCell else { fatalError() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyTienHoaHongTableViewCell", for: indexPath) as? BodyTienHoaHongTableViewCell else { fatalError() }

            
            return cell
        }
    }
}

extension TienHoaHongViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataNhanVien.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataNhanVien[row].hoTen
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNhanVien = dataNhanVien[row].hoTen
        shopTextField.text = selectedNhanVien
        idNhanVien = dataNhanVien[row].id
    }
}

