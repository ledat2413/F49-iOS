//
//  RutLaiChiTietViewController.swift
//  F49
//
//  Created by Le Dat on 9/30/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class RutLaiChiTietViewController: BaseController {
    
    //MARK: --Vars
    var idItem: Int = 0
    var idTab: Int = 0
    var text: String = ""
    fileprivate var tableCellIdentifier: [String] = ["RutVonChiTietTableViewCell","InfoCamDoTableViewCell","RutVon2TableViewCell"]
    
    fileprivate var dataChiTiet: VonDauTuChiTiet?
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: --View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        if idTab != 1 {
            footerView.isHidden = true
        }
    }
    
    
    //MARK: --Func
    fileprivate func setUpUI(){
        displayNavigation()
        displayTableView()
        displayCollectionView()
        loadChiTiet()
        hideKeyboardWhenTappedAround()
        displayFooterView()
    }
    
    fileprivate func displayFooterView(){
        footerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))
    }
    
    fileprivate func displayCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
    }
    
    fileprivate func displayTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        for i in tableCellIdentifier {
            tableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
    }
    
    fileprivate func loadChiTiet(){
        self.showActivityIndicator( view: self.view)

        MGConnection.requestObject(APIRouter.GetDetailRutVonByID(id: idItem), VonDauTuChiTiet.self) { (result, error) in
            self.hideActivityIndicator(view: self.view)
            guard error == nil else {
                self.Alert("\(error?.mErrorMessage ?? ""). Vui lòng thử lại!!!")
                return
            }
            if let result = result {
                self.dataChiTiet = result
                self.tableView.reloadData()
                print(result)
            }
        }
    }
    
    fileprivate func displayNavigation(){
        navigation.title = "Thông tin rút vốn"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RutLaiChiTietViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        default:
            return tableView.frame.height - 40
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Cửa hàng"
                cell.valueLabel.text = dataChiTiet?.tenCuaHang ?? ""
                return cell
            case 1:
                cell.keyLabel.text = "Ngày đầu tư"
                cell.valueLabel.text = dataChiTiet?.ngayGiaoDich ?? ""
                return cell
                
            case 2:
                cell.keyLabel.text = "Số tiền"
                cell.valueLabel.text = "\(dataChiTiet?.soTien ?? 0)"
                return cell
                
            case 3:
                cell.keyLabel.text = "Người thực hiện"
                cell.valueLabel.text = dataChiTiet?.nguoiThucHien ?? ""
                return cell
                
            case 4:
                cell.keyLabel.text = "Ghi chú"
                cell.valueLabel.text = dataChiTiet?.ghiChu ?? ""
                return cell
                
            case 5:
                cell.keyLabel.text = "Trạng thái"
                cell.valueLabel.text = dataChiTiet?.tenTrangThai ?? ""
                cell.valueLabel.textColor = UIColor.systemOrange
                cell.valueLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
                
                return cell
                
            case 6:
                cell.keyLabel.text = "Ý kiến"
                cell.keyLabel.textColor = UIColor.systemGreen
                
                cell.valueLabel.text = ""
                return cell
                
            default:
                return cell
            }
        default:
            if idTab == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVonChiTietTableViewCell", for: indexPath) as? RutVonChiTietTableViewCell else { fatalError()}
                cell.contentLabel.text = text
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RutVon2TableViewCell", for: indexPath) as? RutVon2TableViewCell else { fatalError()}
                cell.upLabel.text = "\(dataChiTiet?.yKien?.HoTen ?? ""),\(dataChiTiet?.yKien?.ThoiGian ?? "")"
                cell.underLabel.text = dataChiTiet?.yKien?.NoiDung
                return cell
            }
            
        }}
}

extension RutLaiChiTietViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if idTab == 1 {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonFooterCollectionViewCell", for: indexPath) as? ButtonFooterCollectionViewCell else { fatalError() }
        if idTab == 1{
            switch indexPath.row {
            case 0:
                cell.thumbnailLabel.backgroundColor = UIColor.groupTableViewBackground
                cell.thumbnailLabel.text = "Từ chối"
                cell.thumbnailLabel.displayCornerRadius(radius: 20)
            case 1:
                cell.thumbnailLabel.backgroundColor = UIColor.orange
                cell.thumbnailLabel.text = "Đồng ý"
                cell.thumbnailLabel.textColor = .white
                cell.thumbnailLabel.displayCornerRadius(radius: 20)
                
            default:
                return cell
            }
        }else {
            cell.thumbnailLabel.backgroundColor = UIColor.groupTableViewBackground
            cell.thumbnailLabel.text = "Đóng"
            cell.thumbnailLabel.displayCornerRadius(radius: 20)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if idTab == 1{
            switch indexPath.row {
            case 0:
                self.navigationController?.popViewController(animated: true)
                break
            case 1:
                let params: [String: Any] = ["id": idItem, "yKien": text, "trangThai": "true"]
                MGConnection.requestObject(APIRouter.PutDuyetRutVon(params: params), VonDauTuChiTiet.self) { (result, error) in
                    guard error == nil else {
                        print("Error: \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                        self.Alert("Duyệt không thành công")
                        return
                    }
                    self.Alert("Duyệt thành công")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Accept"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                break
            default:
                break
            }
        }else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
extension RutLaiChiTietViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if idTab == 1 {
            return CGSize(width: collectionView.frame.width / 2 - 10, height: collectionView.frame.height )
            
        }else {
            return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.height )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if idTab == 1{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }else {
            return UIEdgeInsets(top: 0, left: collectionView.frame.width / 3 - 30, bottom: 0, right: 0)
            
        }
        
    }
}
