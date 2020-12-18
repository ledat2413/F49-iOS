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
    fileprivate var dataCuaHang: [CuaHang] = []
    fileprivate var dataTienIch: [TienIch] = []
    private var numberOfPages = 0
    private let numberOfItemPerPage = 8
    private let numberOfRowInPerPage = 4
    private let numberOfColInPerPage = 2
    var selectedCuaHang: String?
    var idCuaHang: Int = 0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var headerMenu: Menu!
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        navigation()
        setupCollectionView()
        self.hideKeyboardWhenTappedAround()
        
    }   
    
    fileprivate func navigation(){
        headerMenu.callBack = { [weak self] (index) in
            
            guard let wself = self else { return }
            print(index)
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "CamDoViewController") as! CamDoViewController
            itemVC.index = index
            wself.navigationController?.pushViewController(itemVC, animated: true)
        }
    }
    
    
    fileprivate func loadData(){
        MGConnection.requestArray(APIRouter.GetCuaHang, CuaHang.self) { (result, error) in
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataCuaHang = result
                self.headerTextField.text = self.dataCuaHang[0].tenCuaHang
                
            }
        }
    }
    
    fileprivate func loadDashBoard(id: Int){
        self.showActivityIndicator( view: self.bodyCollectionView)
        MGConnection.requestArray(APIRouter.GetTienIch(id: id), TienIch.self) { (result, error) in
            self.hideActivityIndicator(view: self.bodyCollectionView)
            guard error == nil else {
                self.Alert("Lỗi \(error?.mErrorMessage ?? ""). Vui lòng kiểm tra lại!!!")
                return
            }
            if let result = result {
                self.dataTienIch = result
                self.bodyCollectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
          numberOfPages = dataTienIch.count/numberOfItemPerPage + (dataTienIch.count % numberOfItemPerPage == 0 ? 0 : 1)
          pageControl.numberOfPages = numberOfPages
          
          dataTienIch = sortItems(numberOfPages: numberOfPages, numberOfItemPerPage: numberOfItemPerPage, listItems: dataTienIch)
      }
    
    func sortItems(numberOfPages: Int, numberOfItemPerPage: Int, listItems: [TienIch]) -> [TienIch] {
           var result: [TienIch] = []
           
           // init allItems with empty data
           var allItems: [TienIch] = []
           
           for _ in 0..<numberOfPages*numberOfItemPerPage {
               allItems.append(TienIch())
           }
           
           // merge array items
           for i in 0..<listItems.count {
               allItems[i] = listItems[i]
           }
           
           // rearrange items in per page
           for _ in 0..<numberOfPages {
               result.append(contentsOf: arrangeItems(row: numberOfColInPerPage, col: numberOfRowInPerPage, data: allItems))
               for _ in 0..<numberOfItemPerPage {
                   allItems.removeFirst()
               }
           }
           
           return result
       }
       
       func arrangeItems(row: Int, col: Int, data: [TienIch]) -> [TienIch] {
           var result: [TienIch] = []
           for i in 0..<row {
               var row:[TienIch] = []
               for j in 0..<col {
                   row.append(data[(i)+(j*numberOfColInPerPage)])
               }
               result.append(contentsOf: row)
           }
           return result
       }
    
    fileprivate func setUpUI() {
        
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
        footerView.displayTextField(radius: 10, color: UIColor.clear)

        
        bodyCollectionView.register(UINib(nibName: "UtilitiesBodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UtilitiesBodyCollectionViewCell")
       
        bodyCollectionView.delegate = self
        bodyCollectionView.dataSource = self
        
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView().createPicker(tf: headerTextField)
        pickerView.delegate = self
        
        self.createToolbar(textField: headerTextField, selector: #selector(action))
    }
    
    @objc func action() {
        loadDashBoard(id: idCuaHang)
        view.endEditing(true)
    }
}

extension UtilitiesViewController: UICollectionViewDataSource, UICollectionViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let x = scrollView.contentOffset.x
           let w = scrollView.bounds.size.width
           let currentPage = Int(ceil(x/w))
           self.pageControl.currentPage = currentPage
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTienIch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bodyCollectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesBodyCollectionViewCell", for: indexPath) as? UtilitiesBodyCollectionViewCell else {
            fatalError()
        }
        let data = dataTienIch[indexPath.row]
        cell.ui(model: data)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataTienIch[indexPath.row].screenId {
            
        case "HopDongCamDo":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.screenId = dataTienIch[indexPath.row].screenId
            itemVC.loaiHD = 1
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "CamDoGiaDung":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.screenId = dataTienIch[indexPath.row].screenId
            itemVC.loaiHD = 2

            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "HopDongTraGop":
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "HopDongCamDoViewController") as! HopDongCamDoViewController
            itemVC.screenId = dataTienIch[indexPath.row].screenId
            itemVC.loaiHD = 3

            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "RutLai":
            let itemVC = UIStoryboard.init(name: "RUTLAI", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
            itemVC.screenID = dataTienIch[indexPath.row].screenId
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "ThuChi":
            let itemVC = UIStoryboard.init(name: "THUCHI", bundle: nil).instantiateViewController(withIdentifier: "ThuChiViewController") as! ThuChiViewController
            itemVC.screenID = dataTienIch[indexPath.row].screenId
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "TaiSanThanhLy":
            let itemVC = UIStoryboard.init(name: "THANHLYTAISAN", bundle: nil).instantiateViewController(withIdentifier: "ThanhLyTaiSanViewController") as! ThanhLyTaiSanViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "BaoCaoTongHop":
            let itemVC = UIStoryboard.init(name: "BAOCAO", bundle: nil).instantiateViewController(withIdentifier: "BaoCaoViewController") as! BaoCaoViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "RutVon":
            let itemVC = UIStoryboard.init(name: "RUTLAI", bundle: nil).instantiateViewController(withIdentifier: "RutLaiViewController") as! RutLaiViewController
            itemVC.screenID = dataTienIch[indexPath.row].screenId
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        case "TienHoaHong":
            let itemVC = UIStoryboard.init(name: "TIENHOAHONG", bundle: nil).instantiateViewController(withIdentifier: "TienHoaHongViewController") as! TienHoaHongViewController
            self.navigationController?.pushViewController(itemVC, animated: true)
            
        default:
            break
            
        }
    }
}


extension UtilitiesViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bodyCollectionView.frame.width ) / 2, height:( bodyCollectionView.frame.height ) / 4)
        
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
