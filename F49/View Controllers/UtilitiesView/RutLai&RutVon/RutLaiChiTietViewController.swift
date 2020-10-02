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
    
    var dataChiTiet: VonDauTuChiTiet?
    
    //MARK: --IBOutlet
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var yKienTextView: UITextView!
    
    //MARK: --View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    
    //MARK: --Func
    func setUpUI(){
        displayNavigation()
        displayTableView()
        displayCollectionView()
        loadChiTiet()
        displayYkienLabel()
        hideKeyboardWhenTappedAround()

    }
    
    func displayYkienLabel(){
        yKienTextView.displayTextField(radius: 10, color: UIColor.gray)
        yKienTextView.layer.borderWidth = 0.5
    }
    
    func displayCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ButtonFooterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonFooterCollectionViewCell")
    }
    
    func displayTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RutVonChiTietTableViewCell", bundle: nil), forCellReuseIdentifier: "RutVonChiTietTableViewCell")
        tableView.register(UINib(nibName: "InfoCamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCamDoTableViewCell")
    }
    
    func loadChiTiet(){
        MGConnection.requestObject(APIRouter.GetDetailRutVonByID(id: idItem), VonDauTuChiTiet.self) { (result, error) in
            guard error == nil else {
                print("Error \(error?.mErrorMessage ?? "") and \(error?.mErrorCode ?? 0)")
                return
            }
            if let result = result {
                self.dataChiTiet = result
                self.tableView.reloadData()
                print(result)
            }
        }
    }
    
    func displayNavigation(){
        navigation.title = "Thông tin rút vốn"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .allEvents)
        navigation.leftButton.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
    }
    
    func displayUI(){
        footerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 0, height: 3))
    }
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RutLaiChiTietViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height/7)
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCamDoTableViewCell", for: indexPath) as? InfoCamDoTableViewCell else { fatalError() }
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Cửa hàng"
                cell.valueLabel.text = dataChiTiet?.tenCuaHang ?? ""
            case 1:
                cell.keyLabel.text = "Ngày đầu tư"
                cell.valueLabel.text = dataChiTiet?.ngayGiaoDich ?? ""
            case 2:
                cell.keyLabel.text = "Số tiền"
                cell.valueLabel.text = "\(dataChiTiet?.soTien ?? 0)"
            case 3:
                cell.keyLabel.text = "Người thực hiện"
                cell.valueLabel.text = dataChiTiet?.nguoiThucHien ?? ""
            case 4:
                cell.keyLabel.text = "Ghi chú"
                cell.valueLabel.text = dataChiTiet?.ghiChu ?? ""
            case 5:
                cell.keyLabel.text = "Trạng thái"
                cell.valueLabel.text = dataChiTiet?.tenTrangThai ?? ""
                cell.valueLabel.textColor = UIColor.systemOrange
            case 6:
                cell.keyLabel.text = "Ý kiến"
                cell.keyLabel.textColor = UIColor.systemGreen
                cell.valueLabel.text = ""
            default:
              return cell
            }
          return cell
    }
}

