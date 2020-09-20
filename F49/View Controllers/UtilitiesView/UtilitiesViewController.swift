//
//  UtilitiesViewController.swift
//  F49
//
//  Created by Le Dat on 9/16/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UtilitiesViewController: UIViewController {
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(pushCamDoController), name: NSNotification.Name.init("CamDoController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushDinhGiaController), name: NSNotification.Name.init("DinhGiaController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushDoGiaDungController), name: NSNotification.Name.init("DoGiaDungController"), object: nil)
    }
    
    
    @objc func pushCamDoController() {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
        itemVC.key = "A"
        
        self.navigationController?.pushViewController(itemVC, animated: true)
        print("PushToCamDoView")
    }
    @objc func pushDinhGiaController() {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
        
        itemVC.key = "B"
        self.navigationController?.pushViewController(itemVC, animated: true)
        print("PushToDinhGiaView")
    }
    @objc func pushDoGiaDungController() {
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
        itemVC.key = "C"
        self.navigationController?.pushViewController(itemVC, animated: true)
        print("PushToDoGiaDungview")
    }
    
    
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
    
    private func loadDashBoard(id: Int){
        MGConnection.requestArray(APIRouter.GetTienIch(id: id), TienIch.self) { (result, error) in
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
        createPickerView()
        dismissPickerView()
        headerButton.backgroundColor = UIColor.clear
        headerTextField.layer.cornerRadius = 18
        headerTextField.clipsToBounds = true
        headerTextField.backgroundColor = UIColor.clear
        
        headerView.backgroundColor = UIColor.clear
        headerView.layer.cornerRadius = 18
        headerView.clipsToBounds = true
        headerView.layer.borderColor = UIColor.white.cgColor
        headerView.layer.borderWidth  = 1
        
        
        
        bodyCollectionView.register(UINib(nibName: "UtilitiesBodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UtilitiesBodyCollectionViewCell")
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
        displayShadowView(bodyView)
        cornerRadius(bodyCollectionView)
    }
    
    
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 6
    }
    
    func cornerRadius(_ view: UIView){
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        headerTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
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
        switch collectionView {
        case bodyCollectionView:
            return dataTienIch.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bodyCollectionView:
            guard let cell = bodyCollectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesBodyCollectionViewCell", for: indexPath) as? UtilitiesBodyCollectionViewCell else {
                fatalError()
            }
            
            let data = dataTienIch[indexPath.row]
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            cell.titleLabel.text = data.tieuDe
            cell.countLabel.text = data.giaTri
            cell.imageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
            cell.countLabel.text = data.giaTri
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


extension UtilitiesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bodyCollectionView:
            return CGSize(width: (bodyCollectionView.frame.width)/2, height: (bodyCollectionView.frame.height ) / 3)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case bodyCollectionView:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets()
        }
        
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
