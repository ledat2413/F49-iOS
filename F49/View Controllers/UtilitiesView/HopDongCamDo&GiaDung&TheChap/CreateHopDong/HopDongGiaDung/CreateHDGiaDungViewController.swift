//
//  CreateHDGiaDungViewController.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CreateHDGiaDungViewController: BaseController {
    
    //MARK: --Vars
    private var cellIdentifier: [String] = ["Cell1CreateTableViewCell","Cell2CreateTableViewCell","Cell4CreateTableViewCell","Cell5CreateTableViewCell","Cell6CreateTableViewCell"]
    var ngayPicker: UIDatePicker?
    let dateFormatter = DateFormatter()
    let dateFormatOfString = DateFormatter()
    let dateFormatToString = DateFormatter()
    
    var dataLoadTaoMoi: LoadTaoMoiHDGD?
    var dataTienKhach: TienKhachNhanHDGD?
    var dataTinhTienPhi: TinhTien?
    var dataTinhTienLai: TinhTien?
    var idCuaHang: Int = 0
    
    
    var ngayVay: String = ""
    var ngayVaoSo: String = ""

    var tenTS: String = ""
    var idTS: Int = 0
    var tenKH: String = ""
    var idKH: Int = 0
    var soNgayTrongKy: Int = 0
    var soTienVay: Int = 0
    var soTienLai: Int = 0
    var thuPhiTruoc: Bool = false
    var soNgayVay: Int = 0
    var phanTramLai: Double = 0.0
    var phanTramPhi: Double = 0.0
    var soTienLaiTraGop: Int = 0
    var soKyVay: Int = 0
    var ngayCatLai: String = ""
    var valueCatLai: String = ""
    var lai: Int = 0
    var phi: Int = 0
    var tienKhachNhan: Int = 0
    var ghiChu: String = ""
    var moTa: String = ""
    var viTriDeDo: String = ""
    var dinhGia: Int = 0
    var giayToKemTheo: String = ""
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var footerCollectionView: UICollectionView!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    //MARK: --Func
    private func luuHopDong(){
        var params: [String: Any] = [:]
        
             params["ThongTinHopDong"] = [
                 "IDCuaHang" : self.idCuaHang,
                 "IDKhachHang" : self.idKH,
                 "NgayVay" : self.ngayVay ,
                 "SoTienVay" : self.soTienVay,
                 "SoTienLaiTraGop" : self.soTienLaiTraGop,
                 "SoNgayTrongKy": self.soNgayTrongKy,
                 "SoNgayVay" : self.soNgayVay,
                 "SoKyVay": self.soKyVay,
                 "NgayCatLai" : self.ngayCatLai,
                 "CatLaiTruoc" : self.valueCatLai ,
                 "SoTienCatLaiTruoc" : self.lai,
                 "SoTienThuPhi" : self.phi,
                 "ThuPhiTruoc" :self.thuPhiTruoc,
                 "SoTienKhachNhan" :self.tienKhachNhan,
                 "GhiChu" : self.ghiChu
             ]
             params["DSTaiSanTheChap"] = [[
                 "TenVatCamCo" : self.tenTS ,
                 "IDVatCamCo" : self.idTS,
                 "MoTa" : self.moTa ,
                 "ViTriDeDo": self.viTriDeDo,
                 "GiayToKemTheo": self.giayToKemTheo ,
                 "DinhGia": self.dinhGia ,

                 //            "HinhAnh" : [
                 //                "Name" : "Ô tô huyndai xịn",
                 //                "DataAsURL" : "Base64String"
                 //            ],
                 ]]
//        MGConnection.requestObject(APIRouter.LuuHopDongTraGop(params: params), <#T##returnType: Mappable.Protocol##Mappable.Protocol#>, completion: <#T##(Mappable?, BaseResponseError?) -> Void#>)
        
    }
    
    private func setUpUI(){
        
        //Table View
        tableView.delegate = self
        tableView.dataSource = self
        for i in cellIdentifier{
            tableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        
        //Collection View
        footerCollectionView.delegate = self
        footerCollectionView.dataSource = self
        footerCollectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
        footerContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))    
        
        //Navigation
        navigation.title = "Tạo hợp đồng gia dụng"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        
        //Data
        loadTaoMoi()
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //API Request
    func loadTaoMoi(){
        MGConnection.requestObject(APIRouter.LoadTaoMoiHDGD(idCuaHang: idCuaHang), LoadTaoMoiHDGD.self) { (result, error) in
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
        
        params["SoTienVay"] = soTienVay
        params["SoNgayVay"] = soNgayVay
        params["SoNgayTrongKy"] = soNgayTrongKy
        params["CatLaiTruoc"] = dataLoadTaoMoi?.catLaiTruoc

        if let soTienLai = dataTinhTienLai?.soTien{
            params["SoTienLai"] = soTienLai
        }
        
        if let tienThuPhi = dataTinhTienPhi?.soTien {
            params["TienThuPhi"] = tienThuPhi
        }
        params["ThuPhiTruoc"] = thuPhiTruoc
        
        
        MGConnection.requestObject(APIRouter.TinhSoTienKhachNhan(params: params), TienKhachNhanHDGD.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataTienKhach = result
                self.tableView.reloadData()
            }
        }
    }
    
    func TinhTienLai(){
        var params: [String: Any] = [:]
        
        params["SoTienVay"] = soTienVay
        params["PhanTramLai"] = phanTramLai
        params["SoNgayVay"] = soNgayVay
        
        MGConnection.requestObject(APIRouter.TinhTienLai(params: params), TinhTien.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataTinhTienLai = result
                self.tableView.reloadData()
            }
        }
    }
    
    func TinhTienPhi(){
        var params: [String: Any] = [:]
        
        params["SoTienVay"] = soTienVay
        params["PhanTramPhi"] = phanTramPhi
        params["SoNgayVay"] = soNgayVay
        
        MGConnection.requestObject(APIRouter.TinhTienPhi(params: params), TinhTien.self) { (result, error) in
            guard error == nil else { return }
            if let result = result {
                self.dataTinhTienPhi = result
                
                self.tableView.reloadData()
            }
        }
    }
    
    //Open View
    func openView(_ idCell: Int){
        switch idCell {
        case 1: //Khach Hang
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "KhachHangViewController") as! KhachHangViewController
            itemVC.handlerTenKH { (name, id) in
                self.tenKH = name
                self.idKH = id
                self.tableView.reloadData()
            }
            present(itemVC, animated: true, completion: nil)
            break
            
        case 12: // Tai San
            let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "TaiSanHDGDViewController") as! TaiSanHDGDViewController
                        itemVC.handlerTaiSan { (id, ten) in
                            self.tenTS = ten
                            self.idTS = id
                            
                            self.tableView.reloadData()
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
        case 2:
            ngayPicker = UIDatePicker()
            ngayPicker?.datePickerMode = .date
            textField.inputView = ngayPicker
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(CreateHDCamDoViewController.dismissPicker1))
            textField.inputAccessoryView = toolBar
        case 3:
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
        //        tinhSoTienKhachNhan()
        
        view.endEditing(true)
    }
    @objc func dismissPicker2() {
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        ngayVaoSo = dateFormatter.string(from: ngayPicker!.date)
        print(ngayVaoSo)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    
}

extension CreateHDGiaDungViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,12:
            return 40
        default:
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1CreateTableViewCell", for: indexPath) as? Cell1CreateTableViewCell else { fatalError() }
            cell.thumbnailTitleLabel.text = "Hợp đồng gia dụng"
            cell.thumbnailImageView.isHidden = true
            cell.thumbnailButton.isHidden = true
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Khách hàng"
            cell.celendarButton.isHidden = true
            cell.downButton.isHidden = true
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(indexPath.row)
            }
            cell.enableKeyboard = false
            cell.thumbnailtextField.text = tenKH
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Ngày vay"
            cell.downButton.isHidden = true
            cell.celendarButton.isHidden = false
            cell.enableKeyboard = false
            
            cell.thumbnailtextField.text = dataLoadTaoMoi?.ngayVay
            
            cell.callBackOpenView = { [weak self ] () in
                guard let wself = self else { return }
                wself.openCelendar(2, textField: cell.thumbnailtextField)
            }
            
            dateFormatOfString.dateFormat = "yyyy/MM/dd"
            dateFormatToString.dateFormat = "dd/MM/yyyy"
            
            let date = dateFormatOfString.date(from: ngayVay)
            if let date = date {
                cell.thumbnailtextField.text = dateFormatToString.string(from: date)
            }
            
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Ngày vào sổ"
            cell.downButton.isHidden = true
            cell.celendarButton.isHidden = false
            cell.enableKeyboard = false

            cell.thumbnailtextField.text = dataLoadTaoMoi?.ngayVaoSo
            
            cell.callBackOpenView = { [weak self ] () in
                guard let wself = self else { return }
                wself.openCelendar(indexPath.row, textField: cell.thumbnailtextField)
            }
            
            dateFormatOfString.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            dateFormatToString.dateFormat = "dd/MM/yyyy"
            
            let date = dateFormatOfString.date(from: ngayVaoSo)
            if let date = date {
                cell.thumbnailtextField.text = dateFormatToString.string(from: date)
            }
            
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Số ngày/kỳ"
            cell.downButton.isHidden = true
            cell.celendarButton.isHidden = true
            cell.enableKeyboard = true
            
            cell.callBackValue = { (value) in
                self.soNgayTrongKy = Int(value)!
                self.soNgayTrongKy = self.dataLoadTaoMoi!.soNgayTrongKy
                self.tinhSoTienKhachNhan()
            }

            cell.thumbnailtextField.text = "\(dataLoadTaoMoi?.soNgayTrongKy ?? 0)"
            
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell6CreateTableViewCell", for: indexPath) as? Cell6CreateTableViewCell else { fatalError() }
            
            cell.thumbnail1TextField.text = "\(dataLoadTaoMoi?.soNgayVay ?? 0)"
            
            cell.callBackValue = { (value) in
                self.soNgayVay = Int(value)!
                self.dataLoadTaoMoi?.soNgayVay = self.soNgayVay
                self.tinhSoTienKhachNhan()
            }
            if let sntk = dataLoadTaoMoi?.soNgayTrongKy {
                cell.thumbnail2TextField.text = "\(soNgayVay/sntk) Kỳ"

            }
            
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Số tiền vay"
            cell.downButton.isHidden = true
            cell.celendarButton.isHidden = true
            cell.enableKeyboard = true

            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return}
    
                wself.soTienVay = Int(value)!
                wself.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5CreateTableViewCell", for: indexPath) as? Cell5CreateTableViewCell else { fatalError() }
            cell.thumbnailLabel.text = "Số tiền lãi"
            cell.thumbnail1TextField.text = "\(phanTramLai)"

            cell.callBackValue = { (value) in
                self.phanTramLai = Double(value)!
                self.TinhTienLai()
                self.tinhSoTienKhachNhan()

            }
            
            cell.thumbnail2TextField.text = "\(dataTinhTienLai?.soTien ?? 0)"
            
            return cell
            
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5CreateTableViewCell", for: indexPath) as? Cell5CreateTableViewCell else { fatalError() }
            cell.thumbnailLabel.text = "Tiền thu phí"
            cell.thumbnail1TextField.text = "\(phanTramPhi)"
            
            cell.callBackValue = { (value) in
                self.phanTramPhi = Double(value)!
                self.TinhTienPhi()
                self.tinhSoTienKhachNhan()
            }
            
            cell.thumbnail2TextField.text = "\(dataTinhTienPhi?.soTien ?? 0)"

            return cell
            
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4CreateTableViewCell", for: indexPath) as? Cell4CreateTableViewCell else { fatalError() }
            cell.callBackValue = { (value) in
                self.thuPhiTruoc = value
               
                self.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Trả góp"
            cell.downButton.isHidden = false
            cell.celendarButton.isHidden = true
            cell.enableKeyboard = true
            

            return cell
            
        case 11:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Khách nhận"
            cell.downButton.isHidden = true
            cell.celendarButton.isHidden = true
            
            cell.thumbnailtextField.text = "\(dataTienKhach?.soTienKhachNhan ?? 0)"
            return cell
            
        case 12:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1CreateTableViewCell", for: indexPath) as? Cell1CreateTableViewCell else { fatalError() }
            
            cell.thumbnailTitleLabel.text = "Thông tin tài sản"
            cell.thumbnailImageView.isHidden = false
            cell.thumbnailButton.isHidden = false
            
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(indexPath.row)
            }
            return cell
            
        default:
            return UITableViewCell()
        }        
    }
    
    
}

extension CreateHDGiaDungViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
            //            luuHopDong()
            self.navigationController?.popViewController(animated: true)
            break
        default:
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateHDGiaDungViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: footerCollectionView.frame.width / 2 - 10, height: footerCollectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
}

