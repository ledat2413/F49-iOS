//
//  NotificationViewController.swift
//  F49
//
//  Created by Le Dat on 9/26/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class NotificationViewController: BaseController {
    
    //MARK: --Vars
    var dataNotifi: [Notificationn] = []
    var selectedCuaHang: String?
    var dataCuaHang: [CuaHang] = []
    var pageIndex: Int?
    //    var dataTableView: [T] = []
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemTabBar: UITabBarItem!
    
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
        loadTableView(idShop: 0)
        createPickerView()
        dismissPickerView()
        shopTextField.displayTextField(radius: 15, color: UIColor.white)
        headerContainerView.displayTextField(radius: 15, color: UIColor.white)
        shopTextField.backgroundColor = UIColor.clear
        headerContainerView.backgroundColor = UIColor.clear
        headerContainerView.layer.borderWidth  = 1
        
    }
    
    func loadTableView(idShop: Int){
        var params: [String: Any] = ["idCuaHang" : idShop, "pageSize": 40]
        
        if let pageIndex = pageIndex {
            params = ["pageIndex" : pageIndex]
        }
        self.showSpinner(onView: self.view)
        
        MGConnection.requestArray(APIRouter.GetListNotification(params: params), Notificationn.self) { (result, error) in
            self.removeSpinner()
            
            guard error == nil else {
                print("Error: \(error?.mErrorCode ?? 0) and \(error?.mErrorMessage ?? "")")
                return
            }
            if let result = result {
                self.dataNotifi = result
                self.tableView.reloadData()
            }
        }
        
    }
    
    func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = self.dataCuaHang[0].tenCuaHang
            }
        }
    }
    
    func displayView(_ view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.white.cgColor
    }
    
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 6
        view.clipsToBounds = false
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
    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNotifi.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell else {
            fatalError()
        }
        let data = dataNotifi[indexPath.row]
        
        switch data.screenId {
        case "RutVon_ChiTiet":
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart.fill"))
            
        case "HopDongCamDo_ChiTiet":
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart.fill"))
        default:
            break
        }
        
        if data.daDoc == true {
            cell.daDocImageview.image = UIImage(named: "login-checked")
        }else{
            cell.daDocImageview.isHidden = true
        }
        
        cell.contentLabel.text = data.tieuDe
        cell.dateLabel.text = data.ngayGui
        
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
        loadTableView(idShop: dataCuaHang[row].id)
    }
}
