//
//  NotificationViewController.swift
//  F49
//
//  Created by Le Dat on 9/26/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    //MARK: --Vars
    var dataNotifi: [String] = []
    var selectedCuaHang: String?
    var dataCuaHang: [CuaHang] = []
//    var dataTableView: [T] = []
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    //MARK: --Func
    
    func setUpUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        loadCuaHang()
    }
    
    func loadTableView(id: Int){
        
    }
    
    func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataCuaHang = result
            }
        }
    }

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNotifi.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell else {
            fatalError()
        }
        return cell
        
    }
}

extension NotificationViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        loadTableView(id: dataCuaHang[row].id)
    }
}
