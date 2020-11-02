//
//  TaiSanHDGDViewController.swift
//  F49
//
//  Created by Le Dat on 10/25/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Gallery

class TaiSanHDGDViewController: BaseController {
    
    //MARK: --Vars
    
    var cellIdentifier: [String] = ["Cell2CreateTableViewCell","Cell3CreateTableViewCell"]
    var gallery: GalleryController!
    var itemImages: [UIImage] = []

    var dataTaiSan: [HDGDDSTaiSan] = []
    
    var callBackTS: (([TSTheChap]) -> Void)?
    
    var imgStr: String = ""
    var tenTaiSan: String = ""
    var idTenSan: Int = 0
    var viTri: String = ""
    var dinhGia: Int = 0
    var moTa: String = ""
    var itemImg: [UIImage] = []
    
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
    
    
    func handlerTaiSan(_ handler: @escaping ([TSTheChap]) -> Void){
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
    
    @objc func showImageGallery(){
           self.gallery  = GalleryController()
           self.gallery.delegate = self
           
           Config.Camera.imageLimit = 1
           Config.tabsToShow = [.imageTab,.cameraTab]
           
           self.present(self.gallery, animated: true, completion: nil)
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
            
            cell.callBackValue = { (value) in
                self.viTri = value
                cell.thumbnailtextField.text = self.viTri
                
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Định giá"
            
            cell.callBackValue = { (value) in
                self.dinhGia = Int(value)!
                cell.thumbnailtextField.text = "\(self.dinhGia)"
                
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Mô tả"
            cell.callBackValue = { (value) in
                self.moTa = value
                cell.thumbnailtextField.text = self.moTa
            }
            
            return cell
            
        default:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3CreateTableViewCell", for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
            cell.callBackOpenCamera = { () in
                self.showImageGallery()
                self.itemImages = []
            }
            cell.loadData(itemImages)

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
                    callBackTS([TSTheChap(tenTS: self.tenTaiSan, idTS: self.idTenSan, dinhGia: self.dinhGia, viTri: self.viTri, moTa: self.moTa, imgURL: self.imgStr)])
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
        tenTaiSan =  dataTaiSan[row].tenVatCamCo
        idTenSan = dataTaiSan[row].id
        headerTextField.text = tenTaiSan
    }
}



//Gallery
extension TaiSanHDGDViewController: GalleryControllerDelegate{
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            Image.resolve(images: images) { (imageResolve) in
                print(imageResolve)
                if let image = imageResolve.first ?? UIImage() {
                    let imageData: Data? = self.resizeImage(image: image, newWidth: CGFloat(150)).jpegData(compressionQuality: 1)
                    self.imgStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
                    self.itemImages.append(image)
                     self.tableView.reloadData()
                }
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
