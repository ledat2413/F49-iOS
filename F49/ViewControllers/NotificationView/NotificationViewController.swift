//
//  NotificationViewController.swift
//  F49
//
//  Created by Le Dat on 9/26/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NotificationViewController: BaseController {
 
    
    //MARK: --Vars
    fileprivate var dataNotifi: [Notificationn] = []
    fileprivate var countNotifi: CountNotify?
    fileprivate var selectedCuaHang: String?
    fileprivate var dataCuaHang: [CuaHang] = []
    fileprivate var pageIndex: Int = 0
    fileprivate var idCuaHang: Int = 0
    
    fileprivate var valueBack: String = ""
    fileprivate var dataStr: String?
    var loadMoreView = LoadMoreView.instanceFromNib()

    //    var dataTableView: [T] = []
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var tabbarItem: UITabBarItem!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpUI()

    }
    
    //MARK: --IBAction
    
    @IBAction func readAllPressed(_ sender: Any) {
        putReadAll(idCuaHang)
    }
    
    //MARK: --Func
    
    fileprivate func setUpUI() {
        tableView.tableFooterView = loadMoreView

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        
        hideKeyboardWhenTappedAround()
        loadCuaHang()
        loadTableView()
        createPickerView()
        shopTextField.displayTextField(radius: 15, color: UIColor.white)
        headerContainerView.displayTextField(radius: 15, color: UIColor.white)
        shopTextField.backgroundColor = UIColor.clear
        headerContainerView.backgroundColor = UIColor.clear
        headerContainerView.layer.borderWidth  = 1
        
        getCountNotifi()
        
    }
    
    
    fileprivate func putStatusNotify(_ idCuaHang: Int){
        MGConnection.requestString(APIRouter.PutStatusNotify(idNotify: idCuaHang), returnType: valueBack) { (value, error) in
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
        }
    }
    
    fileprivate func getCountNotifi(){
        MGConnection.requestObject(APIRouter.GetCountNotify(idCuaHang: idCuaHang), CountNotify.self) { (result, error) in
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? "" ). Vui Lòng thử lại!!! ")
                return
            }
            if let result = result {
                if result.countUnread > 0 {
                    self.tabbarItem.badgeValue = "\(result.countUnread)"
                } 
            }
        }
    }
    
    fileprivate func putReadAll(_ idCuaHang: Int) {
        MGConnection.requestString(APIRouter.PutReadAllNotification(idCuaHang: idCuaHang), returnType: valueBack) { (value, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")

                return
                
            }
            if let value = value {
                self.dataStr = value
                self.loadTableView()
            }
        }
    }
    
    fileprivate func loadTableView(){
        
        var params: [String: Any] = ["idCuaHang" : idCuaHang, "pageSize": 30]
        
        params["pageIndex"] = pageIndex
        
        switch pageIndex {
        case 0:
            self.showActivityIndicator( view: self.view)
            break
        default:
            self.loadMoreView.status = .loading
            break
        }
        MGConnection.requestArray(APIRouter.GetListNotification(params: params), Notificationn.self) { (result, error) in
        
            self.hideActivityIndicator(view: self.view)
            self.loadMoreView.status = .finished

            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataNotifi += result
                self.tableView.reloadData()
            }
        }
        
    }
    
    fileprivate func loadCuaHang() {
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = self.dataCuaHang.first?.tenCuaHang
            }
        }
    }
    
    
    fileprivate func deleteNotifi(_ id: Int, indexPath: IndexPath){
        MGConnection.requestString(APIRouter.DeleteNotification(id: id), returnType: valueBack) { (value, error) in
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? "" ). Vui lòng thử lại!!!")
                return
            }
            if let value = value {
                if value.isEmpty {
                    self.handlerAlert(message: "Xoá thành công") {
                        self.dataNotifi.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
    fileprivate func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(action))
    }
    
    
    @objc func action() {
        dataNotifi.removeAll()
        loadTableView()
        getCountNotifi()
        view.endEditing(true)
    }
    
}



extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataNotifi.count - 1 {
            self.pageIndex += 1
            self.loadTableView()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNotifi.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "ChiTietHopDongViewController") as! ChiTietHopDongViewController
        
        if dataNotifi[indexPath.row].daDoc == false {
            putStatusNotify(dataNotifi[indexPath.row].itemId)
        }
        
        itemVC.id = dataNotifi[indexPath.row].itemId
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell else {
            fatalError()
        }
        let data = dataNotifi[indexPath.row]
        cell.daDocImageview.isHidden = true
        
        switch data.screenId {
        case "RutVon_ChiTiet":
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart.fill"))
            
        case "HopDongCamDo_ChiTiet":
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart.fill"))
        default:
            break
        }
        
        if data.daDoc == true {
            cell.backgroundColor = UIColor.groupTableViewBackground
        }else{
            cell.backgroundColor = UIColor.white
            
        }
        
        cell.contentLabel.text = data.tieuDe
        cell.dateLabel.text = data.ngayGui
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.deleteNotifi(dataNotifi[indexPath.row].id, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Xoá"
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
        idCuaHang =  dataCuaHang[row].id
    }
}

