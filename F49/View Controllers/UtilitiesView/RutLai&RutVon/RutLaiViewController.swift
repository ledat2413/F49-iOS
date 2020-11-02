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
    var idTienIch: Int = 0
    let purpleInspireColor = UIColor.orange
    var dataCuaHang: [CuaHang] = []
    var dataTabTrangThai: [TabTrangThai] = [TabTrangThai(id: 0, tenTrangThai: "")]
    var selectedCuaHang: String?
    var idShop: Int = 0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var buttonBarContainerView: UIView!
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: --Func
    
    func setUpUI(){
        
        buttonBarContainerView.layer.borderColor = UIColor.lightGray.cgColor
        buttonBarContainerView.layer.borderWidth = 0.5
        shopContainerView.displayShadowView(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 10)
        loadShop()
        getTabTrangThai()
        createPickerView()
        dismissPickerView()
        displayHeaderView()
        displayTabbarButton(colors: purpleInspireColor)
    }
    
    private func loadShop(){
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.shopTextField.text = self.dataCuaHang[0].tenCuaHang

            }
        }
    }
    
    private func getTabTrangThai(){
        MGConnection.requestArray(APIRouter.GetTabTrangThai, TabTrangThai.self) { (result, error) in
            guard error == nil else {
                print("Error: \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
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
            let vc = UIStoryboard(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiContainerViewController") as! RutLaiContainerViewController
            
            vc.tenTrangThai = i.tenTrangThai
            vc.idTab = i.id
            vc.idShop = self.idShop
            vc.idTienIch = self.idTienIch

            viewControllers.append(vc)
            
        }
        return viewControllers
    }
    
    
    private func displayHeaderView(){
        switch idTienIch {
        case 4:
             navigation.title = "Rút lãi cửa hàng"
              
            break
        case 8:
            navigation.title = "Rút vốn cửa hàng"
                   
            break
            
        default:
            break
            
        }
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
        navigation.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
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
        //        let imageDataDict:[String: Int] = ["idShop": dataCuaHang[row].id]
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: imageDataDict)
        idShop = dataCuaHang[row].id
        reloadPagerTabStripView()
    }
    
}
