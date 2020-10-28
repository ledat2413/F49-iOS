//
//  Cell1UserTableViewCell.swift
//  F49
//
//  Created by Le Dat on 10/27/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class Cell1UserTableViewCell: UITableViewCell {
    
    
    private var dataProfile: [UserProfile] = []
    
    @IBOutlet weak var thumbnailTableView: UITableView!
    @IBOutlet weak var thumbnailContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpTableView(){

        thumbnailContainerView.displayShadowView2(shadowColor: UIColor.lightGray, borderColor: UIColor.clear, radius: 18, offSet: CGSize(width: 1, height: 1))

        thumbnailTableView.layer.cornerRadius = 18
        thumbnailTableView.clipsToBounds = true
        thumbnailTableView.delegate = self
        thumbnailTableView.dataSource = self
        thumbnailTableView.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "NameTableViewCell")
        
        loadUserProfile()
    }
    
    private func loadUserProfile(){
        MGConnection.requestArray(APIRouter.GetUserProfile, UserProfile.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorType))")
                return
            }
            if let result = result {
                self.dataProfile = result
                self.thumbnailTableView.reloadData()
            }
        }
    }
    
}

extension Cell1UserTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(thumbnailTableView.frame.height/7)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProfile.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = thumbnailTableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as? NameTableViewCell else { fatalError() }
        let data = dataProfile[indexPath.row]
        
        switch indexPath.section {
        case 0:
            cell.thumbnailKey.text = "Họ và tên"
            cell.thumbnailValue.text = data.hoTen
            return cell
        case 1:
            cell.thumbnailKey.text = "Ngày sinh"
            cell.thumbnailValue.text = ""
            return cell
        case 2:
            cell.thumbnailKey.text = "Chức vụ"
            cell.thumbnailValue.text = ""
            return cell
        case 3:
            cell.thumbnailKey.text = "Email"
            cell.thumbnailValue.text = data.email
            return cell
        case 4:
            cell.thumbnailKey.text = "Phòng"
            cell.thumbnailValue.text = ""
            return cell
        case 5:
            cell.thumbnailKey.text = "Cửa hàng"
            cell.thumbnailValue.text = ""
            return cell
        case 6:
            cell.thumbnailKey.text = "Phân quyền"
            cell.thumbnailValue.text = data.phanQuyen
            return cell
        default:
            return cell
        }
    }
}
