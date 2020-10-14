//
//  ChiTietHopDongViewController.swift
//  F49
//
//  Created by Le Dat on 9/24/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit
import Floaty

class ChiTietHopDongViewController: BaseController {
    
    //MARK: --Vars
    var id: Int = 0
    var dataChiTiet: ChiTietHopDong?
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainer: UIView!
    
    @IBOutlet weak var floatingContainer: UIView!
    @IBOutlet weak var floatingButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewContainer: UIView!
    
    
    @IBOutlet weak var heightConstrainCollectionView: NSLayoutConstraint!
    
    //MARK: --View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func floatingButtonPressed(_ sender: Any) {
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        itemVC.soHopDong = dataChiTiet?.numberContract ?? ""
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    //MARK: --Func
    
    func setUpUI(){
        floatingButton.layer.cornerRadius = floatingButton.frame.width / 2
        floatingButton.clipsToBounds = true
        floatingContainer.layer.cornerRadius = floatingContainer.frame.width / 2
        floatingContainer.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
        loadData()
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        navigation.title = "Thông tin hợp đồng cầm đồ"
        navigation.rightButton.isHidden = false
        navigation.rightButton.addTarget(self, action: #selector(optionView), for: .allTouchEvents)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataNotifi), name: NSNotification.Name.init("Upload"), object: nil)
    }
    
    
    @objc func loadData(){
        self.showSpinner(onView: self.view)
        MGConnection.requestObject(APIRouter.GetChiTietHopDong(id: id), ChiTietHopDong.self) { (result, error) in
            self.removeSpinner()
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result {
                self.dataChiTiet = result
                self.tableView.reloadData()
                self.collectionView.reloadData()
                if (self.dataChiTiet?.hinhAnh.isEmpty)! {
                         self.collectionViewContainer.isHidden = true
                     }
            }
        }
    }
    
    @objc func reloadDataNotifi(){
        
        self.collectionViewContainer.isHidden = false
        loadData()
    }

    //MARK: --Navigation
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func optionView(){
        let itemVC = UIStoryboard.init(name: "TIENICH", bundle: nil).instantiateViewController(withIdentifier: "OptionViewController") as! OptionViewController
        itemVC.modalPresentationStyle = .overCurrentContext
        itemVC.modalTransitionStyle = .crossDissolve
        itemVC.idHopDong = dataChiTiet!.id
        itemVC.idKhachHang = dataChiTiet!.idKhachHang
        itemVC.tenKhachHang = dataChiTiet!.fullName
        itemVC.soHopDong = dataChiTiet!.numberContract
        itemVC.ngayHieuLuc = dataChiTiet!.appointmentDate
        self.present(itemVC, animated: true, completion: nil)
    }
}

extension ChiTietHopDongViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Số HĐ"
            cell.valueLabel.text = dataChiTiet?.numberContract ?? ""
            return cell
        case 1:
            cell.keyLabel.text = "Tên KH"
            cell.valueLabel.text = dataChiTiet?.fullName ?? ""
            return cell
        case 2:
            cell.keyLabel.text = "Điện thoại"
            cell.valueLabel.text = dataChiTiet?.phoneNumber ?? ""
            return cell
        case 3:
            cell.keyLabel.text = "Dư nợ"
            cell.valueLabel.text = dataChiTiet?.duNo ?? ""
            return cell
        case 4:
            cell.keyLabel.text = "Ngày đến hạn"
            cell.valueLabel.text = dataChiTiet?.appointmentDate ?? ""
            return cell
        case 5:
            cell.keyLabel.text = "+/-"
            cell.valueLabel.text = "\(dataChiTiet?.plusMin ?? 0)"
            return cell
        case 6:
            cell.keyLabel.text = "Lãi"
            cell.valueLabel.text = dataChiTiet?.interest ?? ""
            return cell
        case 7:
            cell.keyLabel.text = "Phí"
            cell.valueLabel.text = dataChiTiet?.fee ?? ""
            return cell
        case 8:
            cell.keyLabel.text = "Tổng"
            cell.valueLabel.text = dataChiTiet?.total ?? ""
            return cell
        case 9:
            cell.keyLabel.text = "Nhắc nợ"
            cell.valueLabel.text = dataChiTiet?.ngayNhacNho ?? ""
            return cell
        case 10:
            cell.keyLabel.text = "Ngày hẹn"
            cell.valueLabel.text = dataChiTiet?.expiredDate ?? ""
            return cell
        case 11:
            cell.keyLabel.text = "Nội dung"
            cell.valueLabel.text = dataChiTiet?.content ?? ""
            return cell
        case 12:
            cell.keyLabel.text = "Đồ để lại"
            cell.valueLabel.text = dataChiTiet?.doDeLai ?? ""
            return cell
        default:
            return cell
        }
    }
}

extension ChiTietHopDongViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataChiTiet?.hinhAnh.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { fatalError() }
        cell.thumbnailImageView.sd_setImage(with: URL(string: (dataChiTiet?.hinhAnh[indexPath.row].url)!), placeholderImage: UIImage(named: "heart.fill"))
        return cell
    }
}

extension ChiTietHopDongViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 150)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 0)
        
    }
}


