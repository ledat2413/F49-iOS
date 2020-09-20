//
//  UserViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    //MARK: --Vars
    var dataProfile: [UserProfile] = []
    let cellIdentifier: [String] = ["NameTableViewCell"]
    let cellIdentifier2: [String] = ["MacDinhTableViewCell","MatKhauTableViewCell","CauHinhTableViewCell"]
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyTableView: UITableView!
    @IBOutlet weak var subBodyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func loadUserProfile(){
        MGConnection.requestArray(APIRouter.GetUserProfile, UserProfile.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorType))")
                return
            }
            if let result = result {
                print(result)
                self.dataProfile = result
                self.bodyTableView.reloadData()
            }
        }
    }
    
    func setUpUI() {
        
        for i in cellIdentifier{
            bodyTableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
        }
        bodyTableView.delegate = self
        bodyTableView.dataSource = self
        
        for j in cellIdentifier2{
            subBodyTableView.register(UINib(nibName: j, bundle: nil), forCellReuseIdentifier: j)
        }
        
        //load Data
        loadUserProfile()
        
        //subBody background color
        subBodyTableView.backgroundColor = UIColor.clear
        subBodyTableView.delegate = self
        subBodyTableView.dataSource = self
        
        //display Avatar
        avatarImageView.layer.borderWidth = 5.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
        
        //display body table view
        bodyView.backgroundColor = UIColor.clear
        bodyView.layer.shadowColor = UIColor.systemGreen.cgColor
        bodyView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        bodyView.layer.shadowOpacity = 0.9
        bodyView.layer.shadowRadius = 1
        self.bodyTableView.layer.cornerRadius = 10
        self.bodyTableView.layer.masksToBounds = true
        self.view.addSubview(bodyView)
        bodyView.addSubview(self.bodyTableView)
        
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case bodyTableView:
            return CGFloat((bodyTableView.frame.width) / 7)
        case subBodyTableView:
            return CGFloat(45)
        default:
            return CGFloat()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case bodyTableView:
            return 7
        case subBodyTableView:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case bodyTableView:
            return dataProfile.count
        case subBodyTableView:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case bodyTableView:
            let data = dataProfile[indexPath.row]
            guard let cell = bodyTableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as? NameTableViewCell else {
                fatalError()
            }
            switch indexPath.section {
            case 0:
                cell.thumbnailKey.text = "Họ và tên"
                cell.thumbnailValue.text = data.hoTen
                return cell
            case 1:
                cell.thumbnailKey.text = "Ngày sinh"
                cell.thumbnailValue.text = "24/01/1998"
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
                cell.thumbnailValue.text = "IT"
                return cell
            case 5:
                cell.thumbnailKey.text = "Cửa hàng"
                cell.thumbnailValue.text = "F49"
                return cell
            case 6:
                cell.thumbnailKey.text = "Phân quyền"
                cell.thumbnailValue.text = data.phanQuyen
                return cell
            default:
                return cell
            }
        case subBodyTableView:
            switch indexPath.section {
            case 0:
                guard let cell = subBodyTableView.dequeueReusableCell(withIdentifier: "MacDinhTableViewCell", for: indexPath) as? MacDinhTableViewCell else {
                    fatalError()
                }
                return cell
            case 1:
                guard let cell = subBodyTableView.dequeueReusableCell(withIdentifier: "MatKhauTableViewCell", for: indexPath) as? MatKhauTableViewCell else {
                    fatalError()
                }
                return cell
            case 2:
                guard let cell = subBodyTableView.dequeueReusableCell(withIdentifier: "CauHinhTableViewCell", for: indexPath) as? CauHinhTableViewCell else {
                    fatalError()
                }
                return cell
                
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == subBodyTableView {
            switch indexPath.section {
            case 0:
                let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CuaHangMacDinhViewController")
                
                self.navigationController?.pushViewController(itemVC, animated: true)
                break
                
            case 1:
                let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatKhauViewController")
                
                self.navigationController?.pushViewController(itemVC, animated: true)
                break
            case 2:
                let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CaiDatViewController")
                
                self.navigationController?.pushViewController(itemVC, animated: true)
                break
            default:
                break
            }
        }
    }
}

