//
//  CreateHDCamDoViewController.swift
//  F49
//
//  Created by Le Dat on 10/14/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Gallery

class CreateHDCamDoViewController: BaseController {
    
    //MARK: --Vars
    var ngayPicker: UIDatePicker?
    let dateFormatter = DateFormatter()
    
    
    var selectedCatLai: String = "Trước"
    let cellIdentifierTableView: [String] = ["Cell1CreateTableViewCell","Cell2CreateTableViewCell","Cell3CreateTableViewCell"]
    
    var idCuaHang: Int = 0
    
    var dataLoadTaoMoi: LoadTaoMoiHDTC?
    var dataTienKhach: SoTienKhachNhan?
    var soHopDong: SoHopDong?
    
    var tenKH: String = ""
    var idKH: Int = 0
    var tenTS: String = ""
    var idTS: Int = 0
    var valueCatLai: Bool = false
    var tienPhuPhi: Int = 0
    var soTienVay: Int = 0
    var valueText: String = ""
    var ghiChu: String = ""
    var hangSX: String = ""
    var ngayVay: String = ""
    var ngayVaoSo: String = ""
    var kyDongLai: Int = 0
    var ngayCatLai: String = ""
    var lai: Int = 0
    var phi: Int = 0
    var laiSuat: Double = 0.0
    var tienKhachNhan: Int = 0
    var imgArr: [String] = []
    var imgStr: String = ""
    var Success: Bool = false
    
    var gallery: GalleryController!
    var itemImages: [UIImage] = []
    
    var dataKeyValue: [KeyValueModel] = [KeyValueModel(title: "Trước", value: true), KeyValueModel(title: "Sau", value: false)]
    
    let dateFormatOfString = DateFormatter()
    let dateFormatToString = DateFormatter()
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var footerCollectionView: UICollectionView!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        loadTaoMoi()
    }
    
}

extension CreateHDCamDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[0]) as? Cell1CreateTableViewCell else { fatalError() }
        cell.thumbnailImageView.isHidden = true
        cell.thumbnailButton.isHidden = true
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataLoadTaoMoi?.canChangeNgayVay == false {
            switch indexPath.row {
            case 3:
                return 110
            default:
                return 50
            }
        }else {
            switch indexPath.row {
            case 4:
                return 110
            default:
                return 50
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataLoadTaoMoi?.canChangeNgayVay == false {
            return 13
        }
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataLoadTaoMoi?.canChangeNgayVay == false {
            switch indexPath.row {
                
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Khách hàng"
                cell.callBackOpenView = { [weak self] () in
                    guard let wself = self else { return }
                    wself.openView(0)
                }
                cell.enableKeyboard = false
                cell.thumbnailtextField.text = tenKH
                cell.callBackValue = nil
                return cell
                
            case 1:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Ngày vay"
                cell.celendarButton.isHidden = false
                cell.thumbnailtextField.isEnabled = false
                cell.thumbnailtextField.textColor = .lightGray
                cell.enableKeyboard = true
                
                cell.thumbnailtextField.text = dataLoadTaoMoi?.ngayVay
                
                cell.callBackOpenView = { [weak self ] () in
                    guard let wself = self else { return }
                    wself.openCelendar(1, textField: cell.thumbnailtextField)
                }
                cell.thumbnailtextField.isEnabled = false
                
                
                return cell
                
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Tài sản"
                cell.downButton.isHidden = false
                cell.enableKeyboard = false
                
                cell.callBackOpenView = { [weak self] () in
                    guard let wself = self else { return }
                    wself.openView(2)
                }
                cell.callBackValue = nil
                
                cell.thumbnailtextField.text = tenTS
                return cell
                
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[2], for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
                cell.callBackOpenCamera = { [weak self] () in
                    guard let wself = self else { return }
                    wself.showImageGallery()
                    wself.itemImages = []
                }
                return cell
                
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Số tiền vay"
                cell.enableKeyboard = true
                cell.thumbnailtextField.keyboardType = .numberPad
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.soTienVay = Int(value)!
                    wself.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Lãi suất"
                cell.enableKeyboard = true
                cell.thumbnailtextField.text = "\(dataLoadTaoMoi?.laiXuat ?? 0)"
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.dataLoadTaoMoi?.laiXuat = Int(value)!
                    wself.laiSuat = Double(value)!
                    wself.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 6:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Kì đóng lãi"
                cell.enableKeyboard = true
                cell.thumbnailtextField.text = "\(dataLoadTaoMoi?.kyDongLai ?? 0)"
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.dataLoadTaoMoi?.kyDongLai = Int(value)!
                    wself.kyDongLai = Int(value)!
                    wself.tinhSoTienKhachNhan()
                }
                return cell
                
            case 7:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Ngày cắt lãi"
                cell.celendarButton.isHidden = false
                cell.enableKeyboard = false
                cell.thumbnailtextField.textColor = .lightGray
                
                cell.callBackOpenView = nil
                cell.thumbnailtextField.text = dataTienKhach?.ngayDongLai
                
                dateFormatOfString.dateFormat = "dd/MM/yyyy"
                dateFormatToString.dateFormat = "yyyy/MM/dd"
                
                if let ngayDongLai = dataTienKhach?.ngayDongLai {
                    let date = dateFormatOfString.date(from: ngayDongLai)
                    if let date = date {
                        self.ngayCatLai = dateFormatToString.string(from: date)
                        print(ngayCatLai)
                    }
                    
                }
                
                
                return cell
                
            case 8:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Cắt lãi"
                cell.downButton.isHidden = false
                cell.enableKeyboard = true
                
                cell.callBackOpenView =  { [weak self] () in
                    guard let wself = self else {return}
                    wself.openCatLaiPicker(cell.thumbnailtextField)
                }
                
                if dataLoadTaoMoi?.catLaiTruoc == false {
                    cell.thumbnailtextField.text = "Sau"
                }else {
                    cell.thumbnailtextField.text = "Trước"
                }
                
                return cell
                
            case 9:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Lãi"
                cell.enableKeyboard = false
                
                cell.thumbnailtextField.text = "\(self.lai)"
                return cell
                
            case 10:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Phí"
                cell.celendarButton.isHidden = true
                cell.downButton.isHidden = true
                cell.thumbnailtextField.text = "\(self.phi)"
                
                return cell
                
            case 11:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Khách nhận"
                cell.celendarButton.isHidden = true
                cell.downButton.isHidden = true
                cell.callBackOpenView = nil
                
                cell.thumbnailtextField.text = "\(dataTienKhach?.soTienKhachNhan ?? 0)"
                self.tienKhachNhan = dataTienKhach?.soTienKhachNhan ?? 0
                return cell
                
            case 12:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Nội dung"
                cell.enableKeyboard = true
                cell.callBackOpenView = nil
                cell.celendarButton.isHidden = true
                cell.downButton.isHidden = true
                
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.valueText = value
                }
                
                cell.thumbnailtextField.text = valueText
                
                return cell
                
            default:
                return UITableViewCell()
            }
        }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Khách hàng"
            cell.thumbnailtextField.placeholder = "Tên khách hàng"
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(indexPath.row)
            }
            cell.enableKeyboard = false
            cell.thumbnailtextField.text = tenKH
            cell.callBackValue = nil
            return cell
            
        case 1:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.celendarButton.isHidden = false
            cell.enableKeyboard = true
            
            cell.keyLabel.text = "Ngày vay"
            
            cell.thumbnailtextField.text = dataLoadTaoMoi?.ngayVay
            
            cell.callBackOpenView = { [weak self ] () in
                guard let wself = self else { return }
                wself.openCelendar(1, textField: cell.thumbnailtextField)
            }
            dateFormatOfString.dateFormat = "yyyy/MM/dd"
            dateFormatToString.dateFormat = "dd/MM/yyyy"
            
            let date = dateFormatOfString.date(from: ngayVay)
            if let date = date {
                cell.thumbnailtextField.text = dateFormatToString.string(from: date)
            }
            
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.thumbnailtextField.keyboardType = .default
            cell.enableKeyboard = true
            
            cell.keyLabel.text = "Ngày vào sổ"
            cell.celendarButton.isHidden = false
            
            cell.thumbnailtextField.text = dataLoadTaoMoi?.ngayVaoSo
            
            cell.callBackOpenView = { [weak self ] () in
                guard let wself = self else { return }
                wself.openCelendar(2, textField: cell.thumbnailtextField)
            }
            dateFormatOfString.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
            dateFormatToString.dateFormat = "dd/MM/yyyy"
            
            let date = dateFormatOfString.date(from: ngayVaoSo)
            if let date = date {
                cell.thumbnailtextField.text = dateFormatToString.string(from: date)
            }
            
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Tài sản"
            cell.downButton.isHidden = false
            cell.enableKeyboard = false
            cell.thumbnailtextField.placeholder = "Tên tài sản"
            
            cell.callBackValue = nil
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(indexPath.row)
            }
            
            cell.thumbnailtextField.text = tenTS
            return cell
            
        case 4: //Images
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[2], for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
            
            cell.callBackOpenCamera = { [weak self] () in
                guard let wself = self else { return }
                wself.showImageGallery()
                wself.itemImages = []
            }
            
            cell.loadData(itemImages)
            
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Số tiền vay"
            cell.enableKeyboard = true
            cell.thumbnailtextField.keyboardType = .numberPad
            cell.thumbnailtextField.placeholder = "Số tiền vay"
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.soTienVay = Int(value)!
                wself.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Lãi suất"
            cell.enableKeyboard = true
            cell.thumbnailtextField.text = "\(dataLoadTaoMoi?.laiXuat ?? 0)"
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.dataLoadTaoMoi?.laiXuat = Int(value)!
                wself.laiSuat = Double(value)!
                wself.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Kì đóng lãi"
            cell.enableKeyboard = true
            cell.thumbnailtextField.text = "\(dataLoadTaoMoi?.kyDongLai ?? 0)"
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.dataLoadTaoMoi?.kyDongLai = Int(value)!
                wself.tinhSoTienKhachNhan()
            }
            return cell
            
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Ngày cắt lãi"
            cell.celendarButton.isHidden = false
            cell.enableKeyboard = false
            cell.thumbnailtextField.textColor = .lightGray
            
            cell.callBackOpenView = nil
            cell.thumbnailtextField.text = dataTienKhach?.ngayDongLai
            
            dateFormatOfString.dateFormat = "dd/MM/yyyy"
            dateFormatToString.dateFormat = "yyyy-MM-dd"
            
            if let ngayDongLai = dataTienKhach?.ngayDongLai {
                let date = dateFormatOfString.date(from: ngayDongLai)
                if let date = date {
                    self.ngayCatLai = dateFormatToString.string(from: date)
                }
                
            }
            return cell
            
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Cắt lãi"
            cell.downButton.isHidden = false
            cell.enableKeyboard = true
            
            cell.callBackOpenView =  { [weak self] () in
                guard let wself = self else {return}
                wself.openCatLaiPicker(cell.thumbnailtextField)
            }
            
            if dataLoadTaoMoi?.catLaiTruoc == false {
                cell.thumbnailtextField.text = "Sau"
            }else {
                cell.thumbnailtextField.text = "Trước"
            }
            
            return cell
            
        case 10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Lãi"
            cell.enableKeyboard = true
            
            cell.callBackOpenView = nil
            cell.thumbnailtextField.text = "\(self.lai)"
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.lai = Int(value) ?? 0
            }
            return cell
            
        case 11:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Phí"
            cell.enableKeyboard = true
            cell.celendarButton.isHidden = true
            cell.downButton.isHidden = true
            cell.callBackOpenView = nil
            
            cell.thumbnailtextField.text = "\(self.phi)"
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.phi = Int(value) ?? 0
            }
            
            return cell
            
        case 12:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Khách nhận"
            cell.celendarButton.isHidden = true
            cell.downButton.isHidden = true
            cell.callBackOpenView = nil
            
            cell.thumbnailtextField.text = "\(dataTienKhach?.soTienKhachNhan ?? 0)"
            self.tienKhachNhan = dataTienKhach?.soTienKhachNhan ?? 0
            return cell
            
        case 13:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.keyLabel.text = "Nội dung"
            cell.enableKeyboard = true
            cell.callBackOpenView = nil
            cell.celendarButton.isHidden = true
            cell.downButton.isHidden = true
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.valueText = value
            }
            
            cell.thumbnailtextField.text = valueText 
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

