//
//  TaiSanViewController.swift
//  F49
//
//  Created by Le Dat on 10/17/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class TaiSanViewController: BaseController {
    
    //MARK: --Vars
    private var DSTSHDTheChap: [TaiSanHDTheChap] = []
    private var datathuocTinh: [ThuocTinhTaiSanHDTheChap] = []
    private var selectedTaiSan: String?
    private var idTaiSan: Int?
    private var pickerTaiSan: UIPickerView?
    private var loadiTaiSan: String?
    
    var valueTaiSan:((_ ten: String, _ id: Int, _ hang: String) -> Void)?
    
    @IBOutlet weak var findViewContainer: UIView!
    @IBOutlet weak var findTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var footerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
    }
    
    deinit {
        print("deinit taisanview")
    }
    //MARK: --Func
    
    func handlerValueTS(handler: @escaping (_ ten: String, _ id: Int , _ hang: String) -> Void){
        self.valueTaiSan = handler
    
    }
    
    private func setUPUI(){
        
        //Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaiSanHopDongTheChapTableViewCell", bundle: nil), forCellReuseIdentifier: "TaiSanHopDongTheChapTableViewCell")
        
        //Collection View
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        
        findViewContainer.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        footerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        footerContainerView.layer.borderWidth = 1.0
        
        //Data
        loadDSTaiSan()
        loadThuocTinh("")
        createPickerView()
    }
    
    private func loadDSTaiSan(){
        self.showActivityIndicator( view: self.view)

        MGConnection.requestArray(APIRouter.DanhSachTaiSanHDTC, TaiSanHDTheChap.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else { return }
            if let result = result {
                self.DSTSHDTheChap = result
                self.tableView.reloadData()
            }
        }
    }
    
    private func loadThuocTinh(_ loaiTaiSan: String){
        MGConnection.requestArray(APIRouter.ThuocTinhTaiSanHDTC(loaiTaiSan: loaiTaiSan), ThuocTinhTaiSanHDTheChap.self) { (result, error) in
             guard error == nil else { return }
                       if let result = result {
                           self.datathuocTinh = result
                           self.tableView.reloadData()
                       }
        }
    }
    
     func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: findTextField)
         pickerView.delegate = self
//         findTextField.inputView = pickerView
        self.createToolbar(textField: findTextField, selector: #selector(action))
        
     }

     @objc func action() {
        loadThuocTinh(loadiTaiSan ?? "")
         view.endEditing(true)
     }
    
    //MARK: --IBAction
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TaiSanViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60.0)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datathuocTinh.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaiSanHopDongTheChapTableViewCell", for: indexPath) as? TaiSanHopDongTheChapTableViewCell else { fatalError()}
        cell.keyLabel.text = datathuocTinh[indexPath.row].title
        cell.valueTextField.text = datathuocTinh[indexPath.row].dataType
        return cell
    
    }
}

extension TaiSanViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = footerCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
        switch indexPath.row {
        case 0:
     
            cell.ui(color: Colors.orange, textString: "Lưu")
        case 1:
            cell.thumbnailLabel.textColor = .white
            cell.ui(color: Colors.red, textString: "Đóng")
        default:
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.dismiss(animated: true) {
                if let valueTaiSan = self.valueTaiSan {
                    valueTaiSan(self.selectedTaiSan ?? "nil", self.idTaiSan ?? 0, self.datathuocTinh[indexPath.row].title)
                    }
            }
            break
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   
}

extension TaiSanViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: footerCollectionView.frame.width / 2 - 5, height: footerCollectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension TaiSanViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DSTSHDTheChap.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DSTSHDTheChap[row].tenVatCamCo
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTaiSan =  DSTSHDTheChap[row].tenVatCamCo
        idTaiSan = DSTSHDTheChap[row].id
        loadiTaiSan = DSTSHDTheChap[row].loai
        findTextField.text = selectedTaiSan
    }
}
