//
//  TaiSanHDGDViewController.swift
//  F49
//
//  Created by Le Dat on 10/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class TaiSanHDGDViewController: BaseController {
    
    //MARK: --Vars
    
    var cellIdentifier: [String] = ["Cell2CreateTableViewCell","Cell3CreateTableViewCell"]
    
    var dataTaiSan: [HDGDDSTaiSan] = []
    
    var selectedTaiSan: String?
    var callBackTS: ((_ idTS: Int, _ TenTS: String) -> Void)?
    //MARK: --IBOutlet
    
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerTextField: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerCollectionView: UICollectionView!
    @IBOutlet weak var footerContainerView: UIView!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    //MARK: --IBAction
    
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: --Func
    
    
    func handlerTaiSan(_ handler: @escaping (_ idTS: Int, _ tenTS: String) -> Void){
        self.callBackTS = handler
    }
    func setUpUI(){
        
        //Table View
        tableView.delegate = self
        tableView.dataSource = self
        for i in cellIdentifier {
            tableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        //Collection View
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        
        //Footer
        footerContainerView.layer.borderColor = UIColor.lightGray.cgColor
        footerContainerView.layer.borderWidth = 1.0
        
        //Header
        headerContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        loadDSTaiSan()
        createPickerView()
    }
    
    //API Request
    func loadDSTaiSan(){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.DanhSachTaiSanHDGD, HDGDDSTaiSan.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else { return}
            if let result = result {
                self.dataTaiSan = result
                self.tableView.reloadData()
            }
        }
    }
    
    //Picker View
    func createPickerView() {
            let pickerView = UIPickerView()
            pickerView.delegate = self
            headerTextField.inputView = pickerView
           
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

extension TaiSanHDGDViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 3:
            return CGFloat(120)
        default:
            return CGFloat(50)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Vị trí"
            cell.thumbnailtextField.text = "Vị trí"
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.thumbnailtextField.text = "Định giá"
            cell.keyLabel.text = "Định giá"

            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.thumbnailtextField.text = "Mô tả"
            cell.keyLabel.text = "Mô tả"
            return cell
            
        default:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3CreateTableViewCell", for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
            return cell
        }
    }
    
    
}


extension TaiSanHDGDViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = footerCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.thumbnailLabel.backgroundColor = UIColor.orange
            cell.thumbnailLabel.text = "Lưu"
            cell.thumbnailLabel.display20()
        case 1:
            cell.thumbnailLabel.backgroundColor = UIColor.red
            cell.thumbnailLabel.text = "Đóng"
            cell.thumbnailLabel.textColor = .white
            cell.thumbnailLabel.display20()
        default:
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
                        self.dismiss(animated: true) {
                            if let callBackTS = self.callBackTS {
                                callBackTS(self.dataTaiSan[indexPath.row].id, self.dataTaiSan[indexPath.row].tenVatCamCo)
                                }
                        }
            break
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension TaiSanHDGDViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: footerCollectionView.frame.width / 2 - 5, height: footerCollectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


extension TaiSanHDGDViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataTaiSan.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataTaiSan[row].tenVatCamCo
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTaiSan =  dataTaiSan[row].tenVatCamCo
        headerTextField.text = selectedTaiSan
    }
}
