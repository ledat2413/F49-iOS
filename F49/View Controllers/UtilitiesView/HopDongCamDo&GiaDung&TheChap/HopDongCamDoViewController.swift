//
//  HopDongCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HopDongCamDoViewController: BaseController{
    
    //MARK: --Vars
    var screenId: String = ""
    let purpleInspireColor = UIColor.orange
    var dataCuaHang: [CuaHang] = []
    var dataHopDong: [HopDongTheoLoai] = []
    var dataTab: [Tab] = [Tab(id: 0, value: "")]
    var selectedCuaHang: String?
    var idShop: Int = 0
    var idStatus: String?
    var keyWord: String?
    var loaiHD: Int = 0
    var isHidden: Bool = false
    
    //MARK: --IBOutlet
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var contrectLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var floatingButtonContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.hideKeyboardWhenTappedAround()
        
        
    }
    
    //MARK: --IBAction
    
    @IBAction func floatingButtonPressed(_ sender: Any) {
        switch screenId {
        case "HopDongCamDo":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "CreateHDCamDoViewController") as! CreateHDCamDoViewController
            
            itemVC.idCuaHang = idShop
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        case "CamDoGiaDung":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "CreateHDGiaDungViewController") as! CreateHDGiaDungViewController
            itemVC.screenID = screenId
            itemVC.idCuaHang = idShop
            
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
            
        case "HopDongTraGop":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "CreateHDGiaDungViewController") as! CreateHDGiaDungViewController
            itemVC.screenID = screenId
            itemVC.idCuaHang = idShop
            
            self.navigationController?.pushViewController(itemVC, animated: true)
            break
        default:
            break
        }
        
    }

    @IBAction func locButtonPressed(_ sender: UIButton) {
        let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "BoLocViewController") as! BoLocViewController
        itemVC.modalPresentationStyle = .overCurrentContext
        itemVC.modalTransitionStyle = .crossDissolve
        itemVC.callBackValue = { (idStatus, text) in
            self.idStatus = idStatus
            self.keyWord = text
            self.loadData()
        }
        self.present(itemVC, animated: true, completion: nil)


    }
    
    
    //MARK: --Func
    
    private func loadShop(){
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = self.dataCuaHang[0].tenCuaHang
                self.floatingButtonContainer.isHidden = true
            }
        }
    }
    
    private func loadStatus(){
        MGConnection.requestArray(APIRouter.GetTab, Tab.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return  
            }
            if let result = result {
                self.dataTab = result
            }
        }
    }
    
    func loadData(){
         var params: [String: Any] = ["idCuaHang": idShop, "loaiHD": loaiHD]
         
         if let idStatus = self.idStatus {
             params["trangThai"] = idStatus
         }
         if let keyWord = self.keyWord {
             params["tuKhoa"] = keyWord
         }
        self.showActivityIndicator( view: self.view)

        MGConnection.requestArray(APIRouter.GetListHopDongTheoLoai(params: params), HopDongTheoLoai.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
             guard error == nil else {
                 self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                 print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                 return
             }
             if let result = result {
                 self.dataHopDong = result
                 if result.count == 0 {
                     self.Alert("Không có dữ liệu")
                 }
                 self.tableView.reloadData()
             }
         }
     }
    
    func setUpUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContractOpenTableViewCell", bundle: nil), forCellReuseIdentifier: "ContractOpenTableViewCell")
        
        floatingButton.layer.cornerRadius = floatingButton.frame.width / 2
        floatingButton.clipsToBounds = true
        floatingButtonContainer.layer.cornerRadius = floatingButtonContainer.frame.width / 2
        floatingButtonContainer.clipsToBounds = true
        displayHeaderView()
        loadShop()
        loadStatus()
        loadData()
        createPickerView()
        contrectLabel.underlined()
//        displayTabbarButton(colors: UIColor.orange)
        
    }
    
    private func displayHeaderView(){
        switch screenId {
        case "HopDongCamDo":
            headerView.title = "Quản lí hợp đồng cầm đồ"
        case "CamDoGiaDung":
            headerView.title = "Hợp đồng gia dụng"
        case "HopDongTraGop":
            headerView.title = "Hợp đồng thế chấp"
        default:
            break
        }
        
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(self.action))
    }

    @objc func action() {
        loadData()
        view.endEditing(true)
    }
    
}

extension HopDongCamDoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHopDong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractOpenTableViewCell", for: indexPath) as? ContractOpenTableViewCell else{
            fatalError()
        }
        
        let data = dataHopDong[indexPath.row]
        cell.ui(model: data)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "ChiTietHopDongViewController") as! ChiTietHopDongViewController
        itemVC.id = dataHopDong[indexPath.row].id
        self.navigationController?.pushViewController(itemVC, animated: true)
     
    }
    
    
}

extension HopDongCamDoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        if dataCuaHang[row].id == 0 {
            self.floatingButtonContainer.isHidden = true
        }else{
            self.floatingButtonContainer.isHidden = false
        }
        
    }
}


