//
//  HopDongCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 9/22/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SnapKit

class HopDongCamDoViewController: ButtonBarPagerTabStripViewController{
    
    //MARK: --Vars
    var views: [UIView] = []
    let purpleInspireColor = UIColor.orange
    var dataCuaHang: [CuaHang] = []
    var dataTab: [Tab] = [Tab(id: 0, value: "")]
    var selectedCuaHang: String?
//    var callBackIdShop: ((_ id: Int) -> Void)?
    var idShop: Int = 0
    var idStatus: String?
    var keyWord: String?
    
    //MARK: --IBOutlet
    @IBOutlet weak var headerView: NavigationBar!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var contrectLabel: UILabel!

    @IBOutlet var viewTo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        displayHeaderView()
        loadData()
        loadStatus()
        createPickerView()
        dismissPickerView()
        contrectLabel.underlined()
    }
    
    //MARK: --IBAction
    
    @IBAction func locButtonPressed(_ sender: UIButton) {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoLocViewController") as! BoLocViewController
        itemVC.modalPresentationStyle = .overCurrentContext
        itemVC.modalTransitionStyle = .crossDissolve
        itemVC.callBackValue = { (idStatus, text) in
            self.idStatus = idStatus
            self.keyWord = text
            self.reloadPagerTabStripView()
        }
        self.present(itemVC, animated: true, completion: nil)
       
        
    }
    
    //MARK: --Func
        
    
    
    private func loadData(){
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataCuaHang = result
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
    
    func setUpUI(){
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 13)
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .orange
        settings.style.selectedBarBackgroundColor = .orange
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .orange
            newCell?.label.textColor = self?.purpleInspireColor
        }
    }
    
    private func displayHeaderView(){
        headerView.title = "Quản lí hợp đồng cầm đồ"
        headerView.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        headerView.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        
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
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var viewControllers: [UIViewController] = []
        for i in dataTab {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HopDongMoViewController") as! HopDongMoViewController
            vc.id = i.id
            vc.value = i.value
            vc.idShop = self.idShop
            vc.idStatus = self.idStatus
            vc.keyWord = self.keyWord
            viewControllers.append(vc)
            
        }
        return viewControllers
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
//        let imageDataDict:[String: Int] = ["idShop": dataCuaHang[row].id]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: imageDataDict)
        idShop = dataCuaHang[row].id
        reloadPagerTabStripView()
    }
}


