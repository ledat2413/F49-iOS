//
//  HomeViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

//protocol IdCuaHangDelegate {
//    func chooseCuaHang(id: Int)
//}

class HomeViewController: UIViewController {
    
    //MARK: --Vars
    var dataCuaHang: [CuaHang] = []
    var dataDashBoard: [DashBoard] = []
    var selectedCuaHang: String?
    //    var didSelectCuaHang: IdCuaHangDelegate?
    
    
    //MARK: --IBOutlet
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var findContainerView: UIView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var findTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
    
    private func loadDashBoard(id: Int){
        MGConnection.requestArray(APIRouter.GetDashBoard(id: id), DashBoard.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataDashBoard = result
                self.bodyCollectionView.reloadData()
            }
        }
    }
    
    
    func setUpUI() {
        
        loadData()
        createPickerView()
        dismissPickerView()
        
        findButton.backgroundColor = UIColor.clear
        findTextField.layer.cornerRadius = 18
        findTextField.clipsToBounds = true
        findTextField.backgroundColor = UIColor.clear
        
        findContainerView.backgroundColor = UIColor.clear
        findContainerView.layer.cornerRadius = 18
        findContainerView.clipsToBounds = true
        findContainerView.layer.borderColor = UIColor.white.cgColor
        findContainerView.layer.borderWidth  = 1
        
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "home-bg-page")!)
        headerCollectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        headerCollectionView.dataSource = self
        headerCollectionView.delegate = self
        headerCollectionView.backgroundColor = UIColor.clear
        
        bodyCollectionView.register(UINib(nibName: "BodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BodyCollectionViewCell")
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
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
        findTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        findTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return 3
        }
        else if collectionView == bodyCollectionView{
            return dataDashBoard.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case headerCollectionView:
            guard let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {fatalError()}
            let img: [UIImage?] = [UIImage(named: "icon-dashboard-camdo"),UIImage(named: "icon-dashboard-dinhgia"),UIImage(named: "icon-dashboard-dogiadung")]
            let title: [String?] = ["CẦM ĐỒ","ĐỊNH GIÁ","ĐỒ GIA DỤNG"]
            
            cell.thumbnailImageView.image = img[indexPath.row]
            cell.thumbnailTitleLabel.text = title[indexPath.row]
            
            displayShadowView(cell)
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
            cell.layer.shadowRadius = 1.0;
            cell.layer.shadowOpacity = 0.5;
            cell.clipsToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect:  cell.bounds, cornerRadius: cell.thumbnailView.layer.cornerRadius).cgPath
            //            cell.thumbnailCountLabel.text = api[indexPath.row]
            return cell
            
        case bodyCollectionView:
            guard let cell = bodyCollectionView.dequeueReusableCell(withReuseIdentifier: "BodyCollectionViewCell", for: indexPath) as? BodyCollectionViewCell else {fatalError()}
            
            let data = dataDashBoard[indexPath.row]
            
            cell.thumbnailTitleLabel.text = data.tieuDe
            cell.thumbnailCountLabel.text = data.giaTri
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
            
            displayShadowView(cell)
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
            cell.layer.shadowRadius = 1.0;
            cell.layer.shadowOpacity = 0.5;
            cell.clipsToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect:  cell.bounds, cornerRadius: cell.thumbnailCornerRadiusView.layer.cornerRadius).cgPath
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case headerCollectionView:
            return CGSize(width: (headerCollectionView.frame.width)/3 - 20, height: (headerCollectionView.frame.height) - 20)
        case bodyCollectionView:
            return CGSize(width: (bodyCollectionView.frame.width)/2 - 20, height: (bodyCollectionView.frame.height ) / 3 - 20)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case headerCollectionView:
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        case bodyCollectionView:
            return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        default:
            return UIEdgeInsets()
        }
        
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        //        didSelectCuaHang?.chooseCuaHang(id: dataCuaHang[row].id)
        findTextField.text = selectedCuaHang
    }
    
    
}
