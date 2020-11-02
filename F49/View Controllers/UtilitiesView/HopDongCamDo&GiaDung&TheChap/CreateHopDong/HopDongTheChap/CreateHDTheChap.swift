import Foundation
import UIKit
import Gallery

extension CreateHDCamDoViewController {
    
    func luuHopDong(){
        var params: [String: Any] = [:]
        if dataLoadTaoMoi?.canChangeNgayVay == false {
            params["ThongTinHopDong"] = [
                "IDCuaHang" : self.idCuaHang,
                "IDKhachHang" : self.idKH,
                "NgayVay" : self.ngayVay ,
                "SoTienVay" : self.soTienVay,
                "LaiXuat" : self.laiSuat,
                "SoNgayVay" : dataLoadTaoMoi?.kyDongLai ?? 0,
                "NgayCatLai" : self.ngayCatLai,
                "CatLaiTruoc" : self.valueCatLai ,
                "SoTienCatLaiTruoc" : self.lai,
                "SoTienThuPhi" : self.phi,
                "SoTienKhachNhan" :self.tienKhachNhan,
                "GhiChu" : self.valueText
            ]
            params["DSTaiSanTheChap"] = [[
                "TenVatCamCo" : self.tenTS ,
                "IDVatCamCo" : self.idTS,
                "HangSanXuat" : self.hangSX ,
                            "HinhAnh" : [[
                                 "Name" : self.tenTS,
                                 "DataAsURL" : self.imgStr
                            ]],
                ]]
        } else {
            params["ThongTinHopDong"] = [
                "IDCuaHang" : self.idCuaHang,
                "IDKhachHang" : self.idKH,
                "NgayVay" : self.ngayVay ,
                "NgayVaoSo" : self.ngayVaoSo,
                "SoTienVay" : self.soTienVay,
                "LaiXuat" : self.laiSuat,
                "SoNgayVay" : dataLoadTaoMoi?.kyDongLai ?? 0,
                "NgayCatLai" : self.ngayCatLai,
                "CatLaiTruoc" : self.valueCatLai ,
                "SoTienCatLaiTruoc" : self.lai,
                "SoTienThuPhi" : self.phi,
                "SoTienKhachNhan" :self.tienKhachNhan,
                "GhiChu" : self.valueText
            ]
            params["DSTaiSanTheChap"] = [[
                "TenVatCamCo" : self.tenTS ,
                "IDVatCamCo" : self.idTS,
                "HangSanXuat" : self.hangSX ,
                            "HinhAnh" : [[
                                "Name" : self.tenTS,
                                "DataAsURL" : self.imgStr
                           ] ],
                ]]
        }
        
        MGConnection.requestObject(APIRouter.LuuHopDongTheChap(params: params), SoHopDong.self) { (result, error) in
            guard error == nil else {
                return
            }
            if let result = result {
                self.Success = true
                self.soHopDong = result
            }
        }
    }
    
    func loadTaoMoi(){
        MGConnection.requestObject(APIRouter.LoadTaoMoiHDTC(idCuaHang: idCuaHang), LoadTaoMoiHDTC.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataLoadTaoMoi = result
                self.tinhSoTienKhachNhan()
                self.tableView.reloadData()
            }
        }
    }
    
    func tinhSoTienKhachNhan(){
        var params:[String: Any] = [:]
        
        params["NgayVay"] = ngayVay
        
        if let laiXuat = dataLoadTaoMoi?.laiXuat {
            params["LaiXuat"] = Double(laiXuat)
        }
        if let soNgayVay = dataLoadTaoMoi?.kyDongLai{
            params["SoNgayVay"] = soNgayVay
        }
        params["SoTienVay"] = soTienVay
        
        params["CatLaiTruoc"] = dataLoadTaoMoi?.catLaiTruoc
        
        params["TienPhuPhi"] = tienPhuPhi
        
        
        MGConnection.requestObject(APIRouter.TinhSoTienKhachNhan(params: params), SoTienKhachNhan.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataTienKhach = result
                self.tableView.reloadData()
            }
        }
    }
    
    
    //UI
    func setUpUI(){
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
        for i in cellIdentifierTableView{
            tableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        
        //CollectionView
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        
        footerContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        //Navigation
        navigation.title = "Lập hợp đồng cầm đồ"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchDown)
        navigation.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        //Data
        loadTaoMoi()

    }
    
    
    
    //Open Cat Lai
    @objc func openCatLaiPicker(_ textField: UITextField ){
        let catLaiPickerView = UIPickerView()
        catLaiPickerView.delegate = self
        textField.inputView = catLaiPickerView
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(CreateHDCamDoViewController.endPicker))
        textField.inputAccessoryView = toolBar
    }
    
    @objc func endPicker(){
        view.endEditing(true)
    }
    
    
    
    //Date Picker
    @objc func openCelendar(_ idCell: Int,textField: UITextField){
        switch idCell {
            
        case 1:
            ngayPicker = UIDatePicker()
            ngayPicker?.datePickerMode = .date
            textField.inputView = ngayPicker
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(CreateHDCamDoViewController.dismissPicker1))
            textField.inputAccessoryView = toolBar
            
        case 2:
            ngayPicker = UIDatePicker()
            ngayPicker?.datePickerMode = .date
            textField.inputView = ngayPicker
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(CreateHDCamDoViewController.dismissPicker2))
            textField.inputAccessoryView = toolBar
        default:
            break
        }
        
    }
    
    @objc func dismissPicker1() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ngayVay = dateFormatter.string(from: ngayPicker!.date)
        print(ngayVay)
        tableView.reloadData()
        tinhSoTienKhachNhan()
        
        view.endEditing(true)
    }
    @objc func dismissPicker2() {
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        ngayVaoSo = dateFormatter.string(from: ngayPicker!.date)
        print(ngayVaoSo)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    
    //Open View
    @objc func openView(_ idCell: Int){
        if dataLoadTaoMoi?.canChangeNgayVay == false {
            switch idCell {
            case 0: //Khach Hang
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "KhachHangViewController") as! KhachHangViewController
                itemVC.handlerTenKH { (name, id) in
                    self.tenKH = name
                    self.idKH = id
                    self.tableView.reloadData()
                }
                present(itemVC, animated: true, completion: nil)
                break
                
            case 2: // Tai San
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "TaiSanViewController") as! TaiSanViewController
                itemVC.handlerValueTS { (ten, id, hang) in
                    self.tenTS = ten
                    self.idTS = id
                    self.hangSX = hang
                    self.tableView.reloadData()
                }
                present(itemVC, animated: true, completion: nil)
                break
            default:
                break
            }
        } else {
            switch idCell {
            case 0: //Khach Hang
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "KhachHangViewController") as! KhachHangViewController
                itemVC.handlerTenKH { (name, id) in
                    self.tenKH = name
                    self.idKH = id
                    self.tableView.reloadData()
                }
                present(itemVC, animated: true, completion: nil)
                break
                
            case 3: // Tai San
                let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "TaiSanViewController") as! TaiSanViewController
                itemVC.handlerValueTS { (ten, id, hang) in
                    self.tenTS = ten
                    self.idTS = id
                    self.hangSX = hang
                    self.tableView.reloadData()
                }
                present(itemVC, animated: true, completion: nil)
                break
            default:
                break
            }
        }
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func showImageGallery(){
        self.gallery  = GalleryController()
        self.gallery.delegate = self
        
        Config.Camera.imageLimit = 1
        Config.tabsToShow = [.imageTab,.cameraTab]
        
        self.present(self.gallery, animated: true, completion: nil)
    }
}

extension CreateHDCamDoViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = footerCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.thumbnailLabel.backgroundColor = Colors.orange
            cell.thumbnailLabel.text = "LẬP HỢP ĐỒNG"
            cell.thumbnailLabel.textColor = .white
            cell.thumbnailLabel.display20()
        case 1:
            cell.thumbnailLabel.backgroundColor = .systemRed
            cell.thumbnailLabel.text = "ĐÓNG"
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
            if !Success {
                let alert = UIAlertController(title: "Thông Báo", message: "Tạo thành công!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    self.luuHopDong()
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
               
            }else{
                Alert("Tạo không thành không")
            }
           
           
            break
        default:
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateHDCamDoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: footerCollectionView.frame.width / 2 - 10, height: footerCollectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
}

//Gallery
extension CreateHDCamDoViewController: GalleryControllerDelegate{
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            Image.resolve(images: images) { (imageResolve) in
                print(imageResolve)
                if let image = imageResolve.first ?? UIImage() {
                    let imageData: Data? = self.resizeImage(image: image, newWidth: CGFloat(150.0)).jpegData(compressionQuality: 1)
                    self.imgStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
                    print(self.imgStr)
                    self.itemImages.append(image)
                    self.tableView.reloadData()
                }
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        self.tableView.reloadData()

        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        self.tableView.reloadData()

        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.tableView.reloadData()

        controller.dismiss(animated: true, completion: nil)
    }
}

//CatLai
extension CreateHDCamDoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataKeyValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataKeyValue[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCatLai = dataKeyValue[row].title
        self.dataLoadTaoMoi?.catLaiTruoc = dataKeyValue[row].value
        self.valueCatLai = dataKeyValue[row].value
        tinhSoTienKhachNhan()
        //        selectedCatLai = dataCatLai[row]
    }
}
