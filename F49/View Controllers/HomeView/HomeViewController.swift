//
//  HomeViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class HomeViewController: BaseController {
    
    //MARK: --Vars
    var dataCuaHang: [CuaHang] = []
    var dataDashBoard: [DashBoard] = []
    var selectedCuaHang: String?
    var idCuaHang: Int = 0
    
    //MARK: --IBOutlet
    @IBOutlet weak var findContainerView: UIView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var menuCollectionView: Menu!
    
    @IBOutlet weak var barItem: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        navigation()
        self.hideKeyboardWhenTappedAround()

        //        NotificationCenter.default.addObserver(self, selector: #selector(pushCamDoController), name: NSNotification.Name.init("CamDoController"), object: nil)
    }
    
    //MARK: --Func
    
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
                self.findTextField.text = self.dataCuaHang[0].tenCuaHang
            }
        }
    }
    
    private func loadDashBoard(id: Int){
        self.showSpinner(onView: self.view)
        MGConnection.requestArray(APIRouter.GetDashBoard(id: id), DashBoard.self) { (result, error) in
            self.removeSpinner()
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
        loadDashBoard(id: idCuaHang)
        createPickerView()
        
        menuCollectionView.backgroundColor = UIColor.clear
        findButton.backgroundColor = UIColor.clear
        findContainerView.layer.borderWidth  = 1
        
        findTextField.displayTextField(radius: 18, color: UIColor.white)
        findTextField.backgroundColor = UIColor.clear
        
        findContainerView.displayTextField(radius: 18, color: UIColor.white)
        findContainerView.backgroundColor = UIColor.clear
       
//        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "home-bg-page")!)
//        headerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))

        bodyCollectionView.register(UINib(nibName: "BodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BodyCollectionViewCell")
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
    }
    
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        findTextField.inputView = pickerView
        self.createToolbar(textField: findTextField, selector: #selector(action))
    }
    
    
    @objc func action() {
        loadDashBoard(id: idCuaHang)

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
            let newStr = data.tieuDe.uppercased()
            cell.thumbnailTitleLabel.text = newStr
            cell.thumbnailCountLabel.text = data.giaTri
            cell.thumbnailImageView.sd_setImage(with: URL(string: data.hinhAnh), placeholderImage: UIImage(named: "heart"))
            
            cell.displayShadowView(shadowColor: UIColor.gray, borderColor: UIColor.clear, radius: 15)
            cell.thumbnailImageView.displayShadowView(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 15)
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)

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
            return CGSize(width: (bodyCollectionView.frame.width)/2 - 10, height: (bodyCollectionView.frame.height ) / 3 - 30)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case bodyCollectionView:
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
        findTextField.text = selectedCuaHang
    }
}
