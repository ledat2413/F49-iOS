//
//  ExtensionGiaDungViewController.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

extension CreateHDGiaDungViewController{
    
    //MARK: --Func
    func luuHopDong(){
        var params: [String: Any] = [:]
        
        params["ThongTinHopDong"] = [
            "IDCuaHang" : self.idCuaHang,
            "IDKhachHang" : self.idKH,
            "NgayVay" : self.ngayVay,
            "NgayVaoSo": self.ngayVaoSo,
            "SoTienVay" : self.soTienVay,
            "SoNgayTrongKy": self.soNgayTrongKy,
            "SoNgayVay" : self.soNgayVay,
            "SoKyVay": self.soKyVay,
            "CatLaiTruoc" : self.valueCatLai ,
            "SoTienCatLaiTruoc" : self.dataTienKhach?.soTienCatLaiTruoc ?? 0,
            "SoTienThuPhi" : self.phi,
            "ThuPhiTruoc" :self.thuPhiTruoc,
            "SoTienKhachNhan" :self.tienKhachNhan,
            "GhiChu" : self.ghiChu
        ]
        params["DSTaiSanTheChap"] = [[
            "TenVatCamCo" : dataTS.first?.tenTS ?? "" ,
            "IDVatCamCo" : dataTS.first?.idTS ?? 0,
            "MoTa" : dataTS.first?.moTa ?? "" ,
            "ViTriDeDo": dataTS.first?.viTri ?? "",
            "GiayToKemTheo": "" ,
            "DinhGia": dataTS.first?.dinhGia ?? 0 ,
            "HinhAnh" : [[
                "Name" :  dataTS.first?.tenTS ?? "",
                "DataAsURL" : dataTS.first?.imgURL
            ]],
        ]]
        
        switch screenID {
        case "CamDoGiaDung":
            self.showActivityIndicator( view: self.view)

            MGConnection.requestObject(APIRouter.LuuHopDongTraGop(params: params), SoHopDong.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? "" ). Vui lòng thử lại!!!")
                    return
                    
                }
                if let result = result {
                    if (result.soHopDong.isEmpty) {
                        self.Alert("Lỗi. Không tạo được hợp đồng")
                    } else if !(result.soHopDong.isEmpty) {
                        
                        self.handlerAlert(message: "Số hợp đồng của bạn là \(result.soHopDong)") {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }else {
                        self.Alert("Tạo hợp đồng không thành công!")
                    }
                }
            }
            break
        case "HopDongTraGop":
            self.showActivityIndicator( view: self.view)

            MGConnection.requestObject(APIRouter.LuuHopDongHDTG(params: params), SoHopDong.self) { (result, error) in
                self.hideActivityIndicator(view: self.view)
                guard error == nil else {
                    self.Alert("Lỗi \(error?.mErrorMessage ?? "" ). Vui lòng thử lại!!!")
                    return
                    
                }
                if let result = result {
                    if (result.soHopDong.isEmpty) {
                        self.Alert("Lỗi. Không tạo được hợp đồng")
                    } else if !(result.soHopDong.isEmpty) {
                        self.handlerAlert(message: "Số hợp đồng của bạn là \(result.soHopDong)") {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }else {
                        self.Alert("Tạo hợp đồng không thành công!")
                    }
                }
            }
            break
        default:
            break
        }
    }
    
    func setUpUI(){
        
        //Table View
        tableView1.delegate = self
        tableView1.dataSource = self
        for i in cellIdentifier{
            tableView1.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        
        //Collection View
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        footerContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
        
        //Navigation
        switch screenID {
        case "CamDoGiaDung":
            navigation.title = "Tạo hợp đồng gia dụng"
            break
        case "HopDongTraGop":
            navigation.title = "Tạo hợp đồng trả góp"
            break
        default:
            break
        }
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
        
        //Data
        loadTaoMoi()
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //API Request
    func loadTaoMoi(){
        switch screenID {
        case "CamDoGiaDung":
            MGConnection.requestObject(APIRouter.LoadTaoMoiHDGD(idCuaHang: idCuaHang), LoadTaoMoiHDGD.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataLoadTaoMoi = result
                    self.tinhSoTienKhachNhan()
                    self.tableView1.reloadData()
                }
            }
            break
        case "HopDongTraGop":
            MGConnection.requestObject(APIRouter.LoadTaoMoiGDTG(idCuaHang: idCuaHang), LoadTaoMoiHDGD.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataLoadTaoMoi = result
                    self.tinhSoTienKhachNhan()
                    self.tableView1.reloadData()
                }
            }
            break
        default:
            break
        }
         
    }
    
    
    func tinhSoTienKhachNhan(){
        var params:[String: Any] = [:]
        
        params["SoTienVay"] = soTienVay
        params["SoNgayVay"] = soNgayVay
        params["SoNgayTrongKy"] = soNgayTrongKy
        params["CatLaiTruoc"] = valueCatLai
        
        if let soTienLai = dataTinhTienLai?.soTien{
            params["SoTienLai"] = soTienLai
        }
        
        if let tienThuPhi = dataTinhTienPhi?.soTien {
            params["TienThuPhi"] = tienThuPhi
        }
        params["ThuPhiTruoc"] = thuPhiTruoc
        
        switch screenID {
        case "CamDoGiaDung":
            MGConnection.requestObject(APIRouter.TinhSoTienKhachNhan(params: params), TienKhachNhanHDGD.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTienKhach = result
                    self.tableView1.reloadData()
                }
            }
            break
        case "HopDongTraGop":
            MGConnection.requestObject(APIRouter.TinhSoTienKhachNhanGDTG(params: params), TienKhachNhanHDGD.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTienKhach = result
                    self.tableView1.reloadData()
                }
            }
            break
        default:
            break
        }
        
    }
    
    func TinhTienLai(){
        var params: [String: Any] = [:]
        
        params["SoTienVay"] = soTienVay
        params["PhanTramLai"] = phanTramLai
        params["SoNgayVay"] = soNgayVay
        
        switch screenID {
        case "CamDoGiaDung":
            MGConnection.requestObject(APIRouter.TinhTienLai(params: params), TinhTien.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTinhTienLai = result
                    self.tableView1.reloadData()
                }
            }
            break
        case "HopDongTraGop":
            MGConnection.requestObject(APIRouter.TinhTienLaiHDTG(params: params), TinhTien.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTinhTienLai = result
                    self.tableView1.reloadData()
                }
            }
            break
        default:
            break
        }
        
    }
    
    func TinhTienPhi(){
        var params: [String: Any] = [:]
        
        params["SoTienVay"] = soTienVay
        params["PhanTramPhi"] = phanTramPhi
        params["SoNgayVay"] = soNgayVay
        
        switch screenID {
        case "CamDoGiaDung":
            MGConnection.requestObject(APIRouter.TinhTienPhi(params: params), TinhTien.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTinhTienPhi = result
                    
                    self.tableView1.reloadData()
                }
            }
            break
        case "HopDongTraGop":
            MGConnection.requestObject(APIRouter.TinhTienPhiHDTG(params: params), TinhTien.self) { (result, error) in
                guard error == nil else { return }
                if let result = result {
                    self.dataTinhTienPhi = result
                    
                    self.tableView1.reloadData()
                }
            }
            break
        default:
            break   
        }
        
    }
    
    //Open View
    func openView(_ idCell: Int){
        switch idCell {
        case 0: //Khach Hang
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "KhachHangViewController") as! KhachHangViewController
            itemVC.handlerTenKH { (name, id) in
                self.tenKH = name
                self.idKH = id
                self.tableView1.reloadData()
            }
            present(itemVC, animated: true, completion: nil)
            break
            
        case 1: // Tai San
            let itemVC = UIStoryboard.init(name: "CAMDO", bundle: nil).instantiateViewController(withIdentifier: "TaiSanHDGDViewController") as! TaiSanHDGDViewController
            itemVC.modalPresentationStyle = .overCurrentContext
            itemVC.modalTransitionStyle = .crossDissolve
            itemVC.handlerTaiSan { (data) in
                self.dataTS += data
                self.tableView1.reloadData()
            }
            present(itemVC, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    //Open Celendar
    @objc func openCelendar(_ idCell: Int,textField: UITextField){
        switch idCell {
        case 1:
            ngayPicker = UIDatePicker()
            self.createDatePicker(picker: ngayPicker!, selector: #selector(dismissPicker1), textField: textField)
            self.createToolbar(textField: textField, selector: #selector(doneButton))
            
        case 2:
            ngayPicker = UIDatePicker()
            self.createDatePicker(picker: ngayPicker!, selector: #selector(dismissPicker2), textField: textField)
            self.createToolbar(textField: textField, selector: #selector(doneButton))
            
        default:
            break
        }
        
    }
    
    @objc func dismissPicker1() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        ngayVay = dateFormatter.string(from: ngayPicker!.date)
        print(ngayVay)
        
    }
    
    
    @objc func dismissPicker2() {
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        ngayVaoSo = dateFormatter.string(from: ngayPicker!.date)
        print(ngayVaoSo)
        
    }
    
    @objc func doneButton(){
        tableView1.reloadData()
        view.endEditing(true)
    }
    
    //Cat Lai Picker
    @objc func openCatLaiPicker(_ textField: UITextField ){
        let catLaiPickerView = UIPickerView()
        catLaiPickerView.delegate = self
        textField.inputView = catLaiPickerView
        self.createToolbar(textField: textField, selector: #selector(endPicker))
    }
    
    @objc func endPicker(){
        tinhSoTienKhachNhan()
        view.endEditing(true)
    }
}
