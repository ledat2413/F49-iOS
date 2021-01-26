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
    
    lazy var tenKH: String = ""
    lazy var idKH: Int = 0
    lazy var tenTS: String = ""
    lazy var idTS: Int = 0
    lazy var valueCatLai: Bool = false
    lazy var tienPhuPhi: Int = 0
    lazy var soTienVay: Int = 0
    lazy var valueText: String = ""
    lazy var ghiChu: String = ""
    lazy var hangSX: String = ""
    lazy var ngayVay: String = ""
    lazy var ngayVaoSo: String = ""
    lazy var kyDongLai: Int = 0
    lazy var ngayCatLai: String = ""
    lazy var lai: Int = 0
    lazy var phi: Int = 0
    lazy var laiSuat: Double = 0.0
    lazy var tienKhachNhan: Int = 0
    lazy var imgStr: String = ""
    lazy var Success: Bool = false
    
    var gallery: GalleryController!
    var itemImages: [UIImage?] = [UIImage(named: "photo-camera")]
    
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
        hideKeyboardWhenTappedAround()
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
                cell.ui(keyString: "Khách hàng", textFieldValue: tenKH, celendarHidden: true, downHidden: true, enableKeyboard: false)
                cell.callBackOpenView = { [weak self] () in
                    guard let wself = self else { return }
                    wself.openView(0)
                }
                cell.callBackValue = nil
                return cell
                
            case 1:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.ui(keyString: "Ngày vay", textFieldValue: dataLoadTaoMoi?.ngayVay ?? "", celendarHidden: false, downHidden: true, enableKeyboard: true)
                
                cell.thumbnailtextField.textColor = .lightGray
                
                cell.callBackOpenView = { [weak self ] () in
                    guard let wself = self else { return }
                    wself.openCelendar(1, textField: cell.thumbnailtextField)
                }
                
                
                return cell
                
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.ui(keyString: "Tài sản", textFieldValue: tenTS, celendarHidden: true, downHidden: false, enableKeyboard: false)
                cell.callBackOpenView = { [weak self] () in
                    guard let wself = self else { return }
                    wself.openView(2)
                }
                cell.callBackValue = nil
                return cell
                
            case 3:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[2], for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
                cell.callBackOpenCamera = { [weak self] () in
                    guard let wself = self else { return }
                    wself.showImageGallery()
                }
                return cell
                
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                
                cell.ui(keyString: "Số tiền vay", textFieldValue: "", celendarHidden: true, downHidden: true, enableKeyboard: true)
                cell.thumbnailtextField.keyboardType = .numberPad
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.soTienVay = Int(value) ?? 0
                    wself.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.ui(keyString: "Lãi suất", textFieldValue: "\(dataLoadTaoMoi?.laiXuat ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: true)
                cell.enableKeyboard = true
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.dataLoadTaoMoi?.laiXuat = Int(value)!
                    wself.laiSuat = Double(value)!
                    wself.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 6:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                
                cell.ui(keyString: "Kì đóng lãi", textFieldValue: "\(dataLoadTaoMoi?.kyDongLai ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: true)
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.dataLoadTaoMoi?.kyDongLai = Int(value)!
                    wself.kyDongLai = Int(value)!
                    wself.tinhSoTienKhachNhan()
                }
                return cell
                
            case 7:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.ui(keyString: "Ngày cắt lãi", textFieldValue:  dataTienKhach?.ngayDongLai ?? "", celendarHidden: false, downHidden: true, enableKeyboard: false)
                cell.thumbnailtextField.textColor = .lightGray
                cell.callBackOpenView = nil
                
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
                
                cell.callBackOpenView =  { [weak self] () in
                    guard let wself = self else {return}
                    wself.openCatLaiPicker(cell.thumbnailtextField)
                }
                
                if dataLoadTaoMoi?.catLaiTruoc == false {
                    cell.ui(keyString: "Cắt lãi", textFieldValue: "Sau", celendarHidden: true, downHidden: false, enableKeyboard: true)
                }else {
                    cell.ui(keyString: "Cắt lãi", textFieldValue: "Trước", celendarHidden: true, downHidden: false, enableKeyboard: true)
                }
                
                
                return cell
                
            case 9:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                
                cell.ui(keyString: "Lãi", textFieldValue: "\(self.lai)", celendarHidden: true, downHidden: true, enableKeyboard: false)
                
                return cell
                
            case 10:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                
                cell.ui(keyString: "Phí", textFieldValue: "\(self.phi)", celendarHidden: true, downHidden: true, enableKeyboard: true)
                
                return cell
                
            case 11:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.ui(keyString: "Khách nhận", textFieldValue: "\(dataTienKhach?.soTienKhachNhan ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: true)
                cell.callBackOpenView = nil
                self.tienKhachNhan = dataTienKhach?.soTienKhachNhan ?? 0
                return cell
                
            case 12:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                
                cell.ui(keyString: "Nội dung", textFieldValue: valueText, celendarHidden: true, downHidden: true, enableKeyboard: true)
                
                cell.callBackOpenView = nil
                
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return }
                    wself.valueText = value
                }
                
                return cell
                
            default:
                return UITableViewCell()
            }
        }
        
        switch indexPath.row {
        
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.ui(keyString: "Khách hàng", textFieldValue: tenKH, celendarHidden: true, downHidden: true, enableKeyboard: false)
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(0)
            }
            cell.callBackValue = nil
            return cell
            
        case 1:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.ui(keyString: "Ngày vay", textFieldValue: dataLoadTaoMoi?.ngayVay ?? "", celendarHidden: false, downHidden: true, enableKeyboard: true)
            
            cell.thumbnailtextField.textColor = .lightGray
            
            cell.callBackOpenView = { [weak self ] () in
                guard let wself = self else { return }
                wself.openCelendar(1, textField: cell.thumbnailtextField)
            }
            
            
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Ngày vào sổ", textFieldValue: dataLoadTaoMoi?.ngayVaoSo ?? "", celendarHidden: false, downHidden: true, enableKeyboard: true)
            
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
            cell.ui(keyString: "Tài sản", textFieldValue: tenTS, celendarHidden: true, downHidden: false, enableKeyboard: false)
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(3)
            }
            cell.callBackValue = nil
            return cell
            
        case 4: //Images
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[2], for: indexPath) as? Cell3CreateTableViewCell else { fatalError() }
            
            cell.callBackOpenCamera = { [weak self] () in
                guard let wself = self else { return }
                wself.showImageGallery()
            }
            
            cell.loadData(itemImages)
            
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Số tiền vay", textFieldValue: cell.thumbnailtextField.text ?? ""    , celendarHidden: true, downHidden: true, enableKeyboard: true)
            cell.thumbnailtextField.keyboardType = .numberPad
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.soTienVay = Int(value) ?? 0
                wself.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Lãi suất", textFieldValue: "\(dataLoadTaoMoi?.laiXuat ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: true)
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.dataLoadTaoMoi?.laiXuat = Int(value)!
                wself.laiSuat = Double(value)!
                wself.tinhSoTienKhachNhan()
            }
            
            return cell
            
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.ui(keyString: "Kì đóng lãi", textFieldValue: "\(dataLoadTaoMoi?.kyDongLai ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: true)
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.dataLoadTaoMoi?.kyDongLai = Int(value)!
                wself.tinhSoTienKhachNhan()
            }
            return cell
            
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Ngày cắt lãi", textFieldValue: dataTienKhach?.ngayDongLai ?? "", celendarHidden: false, downHidden: true, enableKeyboard: false)
            cell.thumbnailtextField.textColor = .lightGray
            
            cell.callBackOpenView = nil
            
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
            
            cell.ui(keyString: "Cắt lãi", textFieldValue: "Sau", celendarHidden: true, downHidden: false, enableKeyboard: true)
            
            cell.callBackOpenView =  { [weak self] () in
                guard let wself = self else {return}
                wself.openCatLaiPicker(cell.thumbnailtextField)
            }
            
            if dataLoadTaoMoi?.catLaiTruoc == false {
                cell.ui(keyString: "Cắt lãi", textFieldValue: "Sau", celendarHidden: true, downHidden: false, enableKeyboard: true)
            }else {
                cell.ui(keyString: "Cắt lãi", textFieldValue: "Trước", celendarHidden: true, downHidden: false, enableKeyboard: true)
            }
            
            return cell
            
        case 10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Lãi", textFieldValue: "\(self.lai)", celendarHidden: true, downHidden: true, enableKeyboard: true)
            
            cell.callBackOpenView = nil
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.lai = Int(value) ?? 0
            }
            return cell
            
        case 11:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.ui(keyString: "Phí", textFieldValue: "\(self.phi)", celendarHidden: true, downHidden: true, enableKeyboard: true)
            
            cell.callBackOpenView = nil
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.phi = Int(value) ?? 0
            }
            
            return cell
            
        case 12:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            cell.ui(keyString: "Khách nhận", textFieldValue: "\(dataTienKhach?.soTienKhachNhan ?? 0)", celendarHidden: true, downHidden: true, enableKeyboard: false)
            
            cell.callBackOpenView = nil
            
            self.tienKhachNhan = dataTienKhach?.soTienKhachNhan ?? 0
            return cell
            
        case 13:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView[1], for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
            
            cell.callBackOpenView = nil
            
            
            cell.callBackValue = { [weak self] (value) in
                guard let wself = self else { return }
                wself.valueText = value
            }
            cell.ui(keyString: "Nội dung", textFieldValue: valueText, celendarHidden: true, downHidden: true, enableKeyboard: true)
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
}

