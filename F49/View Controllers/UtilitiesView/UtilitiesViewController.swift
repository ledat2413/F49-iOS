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
    var idCuaHang: Int = 0
    
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
        self.hideKeyboardWhenTappedAround()

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
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
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
        self.createToolbar(textField: headerTextField, selector: #selector(action))
    }

    @objc func action() {
        loadDashBoard(id: idCuaHang)
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
        
        if data.giaTri.isEmpty {
            cell.countView.isHidden = true
        }
        
        let upCase = data.tieuDe.uppercased()
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        cell.titleLabel.text = upCase
        cell.imageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
        cell.countLabel.text = data.giaTri
        cell.imageView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataTienIch[indexPath.row].screenId {
            
        case "HopDongCamDo":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.loaiHD = dataTienIch[indexPath.row].id
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "CamDoGiaDung":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.loaiHD = dataTienIch[indexPath.row].id

            self.navigationController?.pushViewController(itemVC, animated: true)
        case "HopDongTraGop":
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.loaiHD = dataTienIch[indexPath.row].id

        self.navigationController?.pushViewController(itemVC, animated: true)
        case "RutLai":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
            itemVC.idTienIch = 4
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "ThuChi":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThuChiViewController") as! ThuChiViewController
            itemVC.idTienIch = 5
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "TaiSanThanhLy":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "ThanhLyTaiSanViewController") as! ThanhLyTaiSanViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "BaoCaoTongHop":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "BaoCaoViewController") as! BaoCaoViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "RutVon":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
            itemVC.idTienIch = 8
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "TienHoaHong":
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "TienHoaHongViewController") as! TienHoaHongViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        default:
            break
            
        }
    }
}


extension UtilitiesViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bodyCollectionView.frame.width/2, height: bodyCollectionView.frame.height/4)
        
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
        headerTextField.text = selectedCuaHang
        idCuaHang = dataCuaHang[row].id
    }
}
