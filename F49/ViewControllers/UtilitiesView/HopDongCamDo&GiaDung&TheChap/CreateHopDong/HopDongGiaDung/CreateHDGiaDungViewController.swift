//
//  CreateHDGiaDungViewController.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Gallery

class CreateHDGiaDungViewController: BaseController {
    
    //MARK: --Vars
    var cellIdentifier: [String] = ["Cell1CreateTableViewCell","Cell2CreateTableViewCell","Cell4CreateTableViewCell","Cell5CreateTableViewCell","Cell6CreateTableViewCell","ThongTinTaiSanTableViewCell"]
    
    var dataKeyValue: [KeyValueModel] = [KeyValueModel(title: "Trước", value: true), KeyValueModel(title: "Sau", value: false)]
    var dataTS: [TSTheChap] = []
    var ngayPicker: UIDatePicker?
    let dateFormatter = DateFormatter()
    let dateFormatOfString = DateFormatter()
    let dateFormatToString = DateFormatter()
    
    var dataLoadTaoMoi: LoadTaoMoiHDGD?
    var dataTienKhach: TienKhachNhanHDGD?
    var dataTinhTienPhi: TinhTien?
    var dataTinhTienLai: TinhTien?
    var dataHopDong: SoHopDong?
    var screenID: String = ""
    var idCuaHang: Int = 0
    
    var selectedCatLai: String?
    var valueCatLai: Bool = false
    var ngayVay: String = ""
    var ngayVaoSo: String = ""
    
    var tenTS: String = ""
    var idTS: Int = 0
    var tenKH: String = ""
    var idKH: Int = 0
    var soNgayTrongKy: Int = 1
    var soTienVay: Int = 0
    var soTienLai: Int = 0
    var thuPhiTruoc: Bool = false
    var soNgayVay: Int = 0
    var phanTramLai: Double = 0.0
    var phanTramPhi: Double = 0.0
    var soTienLaiTraGop: Int = 0
    var soKyVay: Int = 0
    var ngayCatLai: String = ""
    var lai: Int = 0
    var phi: Int = 0
    var tienKhachNhan: Int = 0
    var ghiChu: String = ""
    var moTa: String = ""
    var viTriDeDo: String = ""
    var dinhGia: Int = 0
    var giayToKemTheo: String = ""
    var Success: Bool = false
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView1: UITableView!
    
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var footerCollectionView: UICollectionView!
    
    //MARK: --View Lifecycle
    deinit {
        NotificationCenter.default
            .removeObserver(self, name:  NSNotification.Name("customer"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        hideKeyboardWhenTappedAround()
      
    }
    
}

extension CreateHDGiaDungViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            guard let cell = tableView1.dequeueReusableCell(withIdentifier: "Cell1CreateTableViewCell") as? Cell1CreateTableViewCell else { fatalError() }
            if screenID == "CamDoGiaDung" {
                cell.thumbnailTitleLabel.text = "Hợp đồng gia dụng"
            }else {
                cell.thumbnailTitleLabel.text = "Hợp đồng trả góp"
            } 
            cell.thumbnailImageView.isHidden = true
            cell.thumbnailButton.isHidden = true
            cell.backgroundColor = UIColor.white
            return cell
        default:
            guard let cell = tableView1.dequeueReusableCell(withIdentifier: "Cell1CreateTableViewCell") as? Cell1CreateTableViewCell else { fatalError() }
            cell.thumbnailTitleLabel.text = "Thông tin tài sản"
            cell.thumbnailImageView.isHidden = false
            cell.thumbnailButton.isHidden = false
            cell.callBackOpenView = { [weak self] () in
                guard let wself = self else { return }
                wself.openView(1)
            }
            cell.backgroundColor = UIColor.white
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 50
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 11
        default:
            return dataTS.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Khách hàng"
                cell.celendarButton.isHidden = true
                cell.downButton.isHidden = true
                cell.callBackOpenView = { [weak self] () in
                    guard let wself = self else { return }
                    wself.openView(0)
                }
                cell.enableKeyboard = false
                cell.thumbnailtextField.text = tenKH
                
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Ngày vay"
                cell.downButton.isHidden = true
                cell.celendarButton.isHidden = false
                cell.enableKeyboard = true
                
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Ngày vào sổ"
                cell.downButton.isHidden = true
                cell.celendarButton.isHidden = false
                cell.enableKeyboard = true
                
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
                
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Số ngày/kỳ"
                cell.downButton.isHidden = true
                cell.celendarButton.isHidden = true
                cell.enableKeyboard = true
                cell.thumbnailtextField.keyboardType = .numberPad
                
                cell.callBackValue = { (value) in
                    self.soNgayTrongKy = Int(value) ?? 0
                    self.tinhSoTienKhachNhan()
                }
                
                cell.thumbnailtextField.text = "\(self.soNgayTrongKy)"
                
                return cell
                
            case 4:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell6CreateTableViewCell", for: indexPath) as? Cell6CreateTableViewCell else { fatalError() }
                
                cell.thumbnail1TextField.text = "\(soNgayVay)"
                cell.thumbnail1TextField.keyboardType = .numberPad

                
                cell.callBackValue = { (value) in
                    self.soNgayVay = Int(value) ?? 0
                    self.dataLoadTaoMoi?.soNgayVay = self.soNgayVay
                    self.tinhSoTienKhachNhan()
                }
                
                
                cell.thumbnail2TextField.text = "\(soNgayVay/soNgayTrongKy) Kỳ"
                
                
                
                return cell
                
            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Số tiền vay"
                cell.downButton.isHidden = true
                cell.celendarButton.isHidden = true
                cell.enableKeyboard = true
                cell.thumbnailtextField.keyboardType = .numberPad

                
                
                
                cell.callBackValue = { [weak self] (value) in
                    guard let wself = self else { return}
                    
                    wself.soTienVay = Int(value) ?? 0
                    wself.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 6:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5CreateTableViewCell", for: indexPath) as? Cell5CreateTableViewCell else { fatalError() }
                cell.thumbnailLabel.text = "Số tiền lãi"
                cell.thumbnail1TextField.text = "\(phanTramLai)"
                cell.thumbnail1TextField.keyboardType = .numberPad
                
                cell.callBackValue = { (value) in
                    self.phanTramLai = Double(value)!
                    self.TinhTienLai()
                    self.tinhSoTienKhachNhan()
                    
                }
                
                cell.thumbnail2TextField.text = "\(dataTinhTienLai?.soTien ?? 0)"
                
                return cell
                
            case 7:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell5CreateTableViewCell", for: indexPath) as? Cell5CreateTableViewCell else { fatalError() }
                cell.thumbnailLabel.text = "Tiền thu phí"
                cell.thumbnail1TextField.text = "\(phanTramPhi)"
                cell.thumbnail1TextField.keyboardType = .numberPad

                cell.callBackValue = { (value) in
                    self.phanTramPhi = Double(value)!
                    self.TinhTienPhi()
                    self.tinhSoTienKhachNhan()
                }
                
                cell.thumbnail2TextField.text = "\(dataTinhTienPhi?.soTien ?? 0)"
                
                return cell
                
            case 8:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell4CreateTableViewCell", for: indexPath) as? Cell4CreateTableViewCell else { fatalError() }
                cell.callBackValue = { (value) in
                    self.thuPhiTruoc = value
                    
                    self.tinhSoTienKhachNhan()
                }
                
                return cell
                
            case 9:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Trả góp"
                cell.downButton.isHidden = false
                cell.celendarButton.isHidden = true
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2CreateTableViewCell", for: indexPath) as? Cell2CreateTableViewCell else { fatalError() }
                cell.keyLabel.text = "Khách nhận"
                cell.downButton.isHidden = true
                cell.celendarButton.isHidden = true
                cell.thumbnailtextField.isEnabled = true
                
                cell.enableKeyboard = false
                cell.callBackOpenView = nil
                cell.thumbnailtextField.text = "\(dataTienKhach?.soTienKhachNhan ?? 0)"
                return cell
                
            default:
                return UITableViewCell()
            }
        default:
            guard let cell = tableView1.dequeueReusableCell(withIdentifier: "ThongTinTaiSanTableViewCell", for: indexPath) as? ThongTinTaiSanTableViewCell else { fatalError() }
            
            cell.tenLabel.text = dataTS[indexPath.row].tenTS
            cell.thuTuLabel.text = "\(dataTS[indexPath.row].idTS)"
            
            cell.buttonPressed = { () in
                self.openView(1)
            }
            return cell
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
            cell.thumbnailLabel.displayCornerRadius(radius: 20)
        case 1:
            cell.thumbnailLabel.backgroundColor = .systemRed
            cell.thumbnailLabel.text = "ĐÓNG"
            cell.thumbnailLabel.textColor = .white
            cell.thumbnailLabel.displayCornerRadius(radius: 20)
            
        default:
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            luuHopDong()
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



extension CreateHDGiaDungViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
        //        selectedCatLai = dataCatLai[row]
    }
}
