//
//  TienHoaHongViewController.swift
//  F49
//
//  Created by Le Dat on 10/7/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class TienHoaHongViewController: UIViewController {
    
    //MARK: --Vars
    var selectedNhanVien: String?
    var dataTienHoaHong: [NhanVien] = []
    var dataNhanVien: [NhanVien] = []
    
    var idNhanVien: Int = 0
    var string: String?
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
        dismissPickerView()
    }
    
    func loadNhanVien(){
        MGConnection.requestArray(APIRouter.GetDanhSachNhanVien, NhanVien.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataNhanVien = result
                self.tableView.reloadData()
            }
        }
    }
    
    func loadTableView(){
        
        let params: [String: Any] = ["idNhanVien" : idNhanVien ]
        
        MGConnection.requestArray(APIRouter.GetTienHoaHong(params: params), NhanVien.self) { (result, error) in
            guard error == nil else { return }
            if let result = result{
                self.dataTienHoaHong = result
                self.tableView.reloadData()
            }
        }
    }
    
    func displayNavigation(){
        navigation.title = "Tiền hoa hồng"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
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
            
            if dataTienHoaHong.count == 0 {
                cell.noDataLabel.isHidden = false
            }
            
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
        loadTableView()
    }
}

