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
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
        
        headerCollectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        headerCollectionView.delegate = self
               headerCollectionView.dataSource = self
        headerCollectionView.backgroundColor = UIColor.clear
        
      
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
        case headerCollectionView:
            return 3
        case bodyCollectionView:
            return dataTienIch.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case headerCollectionView:
            guard let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else {
                fatalError()
            }
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
            return cell
            
            
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
        case headerCollectionView:
            return CGSize(width: (headerCollectionView.frame.width)/3 - 20, height: (headerCollectionView.frame.height) - 20)
        case bodyCollectionView:
            return CGSize(width: (bodyCollectionView.frame.width)/2, height: (bodyCollectionView.frame.height ) / 3)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case headerCollectionView:
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
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
