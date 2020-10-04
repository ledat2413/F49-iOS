//
//  UtilitiesViewController.swift
//  F49
//
//  Created by Le Dat on 9/16/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UtilitiesViewController: BaseController {
    
    //MARK: --Vars
    var dataCuaHang: [CuaHang] = []
    var dataTienIch: [TienIch] = []
    var selectedCuaHang: String?
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var headerMenu: Menu!
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        navigation()
        
    }   
    
    private func navigation(){
        headerMenu.callBack = { [weak self] (index) in
            
            guard let wself = self else { return }
            print(index)
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
            itemVC.index = index
            wself.navigationController?.pushViewController(itemVC, animated: true)
        }
    }
    
    
    private func loadData(){
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.headerTextField.text = self.dataCuaHang[0].tenCuaHang
            
            }
        }
    }
    
    private func loadDashBoard(id: Int){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetTienIch(id: id), TienIch.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataTienIch = result
                self.bodyCollectionView.reloadData()
            }
        }
    }
    
    func setUpUI() {
        
        loadData()
        loadDashBoard(id: 0)
        createPickerView()
        dismissPickerView()
        
        headerView.layer.borderWidth  = 1
        headerView.displayTextField(radius: 18, color: UIColor.white)
        headerView.backgroundColor = UIColor.clear
        headerTextField.displayTextField(radius: 18, color: UIColor.white)
        headerTextField.backgroundColor = UIColor.clear
        
        bodyView.displayShadowView(shadowColor: UIColor.gray, borderColor: UIColor.clear, radius: 10)
        bodyCollectionView.displayTextField(radius: 10, color: UIColor.clear)
        
        bodyCollectionView.register(UINib(nibName: "UtilitiesBodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UtilitiesBodyCollectionViewCell")
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        headerTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        headerTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
}

extension UtilitiesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTienIch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bodyCollectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesBodyCollectionViewCell", for: indexPath) as? UtilitiesBodyCollectionViewCell else {
            fatalError()
        }
        
        let data = dataTienIch[indexPath.row]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        cell.titleLabel.text = data.tieuDe
        cell.imageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
        cell.countLabel.text = data.giaTri
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataTienIch[indexPath.row].id {
        case 1:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
        case 4:
           let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
           itemVC.idTienIch = 4
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case 5:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThuChiViewController") as! ThuChiViewController
            itemVC.idTienIch = 5
            self.navigationController?.pushViewController(itemVC, animated: true)
        case 6:
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThanhLyTaiSanViewController") as! ThanhLyTaiSanViewController
        self.navigationController?.pushViewController(itemVC, animated: true)
        case 8:
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
            itemVC.idTienIch = 8
            self.navigationController?.pushViewController(itemVC, animated: true)
        default:
            break
            
        }
    }
}


extension UtilitiesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bodyCollectionView.frame.width)/2, height: (bodyCollectionView.frame.height ) / 3)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
}

extension UtilitiesViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        loadDashBoard(id: dataCuaHang[row].id)
        headerTextField.text = selectedCuaHang
    }
}
