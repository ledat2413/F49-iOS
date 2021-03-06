//
//  RutLaiViewController.swift
//  F49
//
//  Created by Le Dat on 9/29/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RutLaiViewController: TabbarButton {
    
    //MARK: --Vars
    fileprivate var alert = BaseController()
    var screenID: String = ""
    fileprivate let purpleInspireColor = UIColor.orange
    fileprivate var dataCuaHang: [CuaHang] = []
    fileprivate var dataTabTrangThai: [TabTrangThai] = [TabTrangThai(id: 0, tenTrangThai: "")]
    fileprivate var selectedCuaHang: String?
    var idShop: Int = 0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var buttonBarContainerView: UIView!
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        displayTabbarButton(colors: purpleInspireColor)
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: --Func
    
    fileprivate func setUpUI(){
        
        self.hideKeyboardWhenTappedAround()
        
        buttonBarContainerView.layer.borderColor = UIColor.lightGray.cgColor
        buttonBarContainerView.layer.borderWidth = 0.5
        shopContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 10)
        loadShop()
        getTabTrangThai()
        createPickerView()
        displayHeaderView()
    }
    
    fileprivate func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    fileprivate func loadShop(){
        
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.alert.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = self.dataCuaHang[0].tenCuaHang
                
            }
        }
    }
    
    fileprivate func getTabTrangThai(){
        MGConnection.requestArray(APIRouter.GetTabTrangThai, TabTrangThai.self) { (result, error) in
            guard error == nil else {
                self.alert.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataTabTrangThai = result
                self.reloadPagerTabStripView()
            }
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var viewControllers: [UIViewController] = []
        for i in dataTabTrangThai {
            let vc = UIStoryboard(name: "RUTLAI", bundle: nil).instantiateViewController(withIdentifier: "RutLaiContainerViewController") as! RutLaiContainerViewController
            
            vc.tenTrangThai = i.tenTrangThai
            vc.idTab = i.id
            vc.idShop = self.idShop
            vc.screenID = self.screenID
            
            viewControllers.append(vc)
            
        }
        return viewControllers
    }
    
    
    private func displayHeaderView(){
        switch screenID {
        case "RutLai":
            navigation.title = "Rút lãi cửa hàng"
            
            break
        case "RutVon":
            navigation.title = "Rút vốn cửa hàng"
            
            break
            
        default:
            break
            
        }
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
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
        reloadPagerTabStripView()
        view.endEditing(true)
    }
    
}


extension RutLaiViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
    }
    
}
