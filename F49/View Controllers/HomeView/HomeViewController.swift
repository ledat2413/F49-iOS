//
//  HomeViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: --Vars
    var dataCuaHang: [CuaHang] = []
    var dataDashBoard: [DashBoard] = []
    var selectedCuaHang: String?    
    
    //MARK: --IBOutlet
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var findContainerView: UIView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var menuCollectionView: Menu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        navigation()
        //        NotificationCenter.default.addObserver(self, selector: #selector(pushCamDoController), name: NSNotification.Name.init("CamDoController"), object: nil)
    }
    
    //MARK: --Func
    //    @objc func pushCamDoController() {
    //        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
    //        itemVC.key = "A"
    //        self.navigationController?.pushViewController(itemVC, animated: true)
    //        print("PushToCamDoView")
    //    }
    
    private func navigation(){
        menuCollectionView.callBack = { [weak self] (index) in
        
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
        
        menuCollectionView.backgroundColor = UIColor.clear
        findButton.backgroundColor = UIColor.clear
        displayView(findTextField, cornerRadius: 18)
        displayView(findContainerView, cornerRadius: 18)
        findContainerView.layer.borderWidth  = 1
       
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "home-bg-page")!)
        
        bodyCollectionView.register(UINib(nibName: "BodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BodyCollectionViewCell")
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
    }
    
    func displayView(_ view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.white.cgColor
    }
    
    func displayShadowView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 6
        view.clipsToBounds = false
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
        let button = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(self.action))
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
        if collectionView == bodyCollectionView{
            return dataDashBoard.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bodyCollectionView:
            guard let cell = bodyCollectionView.dequeueReusableCell(withReuseIdentifier: "BodyCollectionViewCell", for: indexPath) as? BodyCollectionViewCell else {fatalError()}
            
            let data = dataDashBoard[indexPath.row]
            
            cell.thumbnailTitleLabel.text = data.tieuDe
            cell.thumbnailCountLabel.text = data.giaTri
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
            
            displayShadowView(cell)
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
        case bodyCollectionView:
            return CGSize(width: (bodyCollectionView.frame.width)/2 - 20, height: (bodyCollectionView.frame.height ) / 3 - 30)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case bodyCollectionView:
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
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
        findTextField.text = selectedCuaHang
    }
}
