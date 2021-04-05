//
//  HopDongCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HopDongCamDoViewController:  TabbarButton{
    
    
    //MARK: --IBOutlet
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var contrectLabel: UILabel!
    
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var floatingButtonContainer: UIView!
    
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
    var baseView = BaseController()
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func viewDidLoad() {
        displayTabbarButton(colors: purpleInspireColor)
        super.viewDidLoad()
        setUpUI()
        baseView.hideKeyboardWhenTappedAround()
        
        
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
            self.reloadPagerTabStripView()
        }
        self.present(itemVC, animated: true, completion: nil)


    }
    
    @IBAction func backAction(_ sender: Any) {
        self.backView()
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
                self.reloadPagerTabStripView()
            }
        }
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var viewControllers: [UIViewController] = []
        for i in dataTab {
            let vc = UIStoryboard(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "HopDongMoViewController") as! HopDongMoViewController
            vc.id = i.id
            vc.value = i.value
            vc.idShop = self.idShop
            vc.idStatus = self.idStatus
            vc.keyWord = self.keyWord
            viewControllers.append(vc)
            
        }
        return viewControllers
    }
    
    func setUpUI(){

        
        floatingButton.layer.cornerRadius = floatingButton.frame.width / 2
        floatingButton.clipsToBounds = true
        floatingButtonContainer.layer.cornerRadius = floatingButtonContainer.frame.width / 2
        floatingButtonContainer.clipsToBounds = true
        displayHeaderView()
        loadShop()
        loadStatus()
        createPickerView()
//        contrectLabel.underlined()
        
    }
    
    private func displayHeaderView(){
        switch screenId {
        case "HopDongCamDo":
            TitleLabel.text = "Quản lí hợp đồng cầm đồ"
        case "CamDoGiaDung":
            TitleLabel.text = "Hợp đồng gia dụng"
        case "HopDongTraGop":
            TitleLabel.text = "Quản lí hợp đồng trả góp"
        default:
            break
        }
        
        
    }
    
     func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: shopTextField)
        pickerView.delegate = self
        self.createToolbar(textField: shopTextField, selector: #selector(self.action))
    }

    @objc func action() {
        reloadPagerTabStripView()
        view.endEditing(true)
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


