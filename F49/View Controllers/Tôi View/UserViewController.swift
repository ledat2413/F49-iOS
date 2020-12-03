//
//  UserViewController.swift
//  F49
//
//  Created by Le Dat on 9/9/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class UserViewController: BaseController {
    
    //MARK: --Vars
    
    var dataProfile: [UserProfile] = []
    private var cellIdentifier: [String] = ["Cell1UserTableViewCell","MacDinhTableViewCell"]
    var height: CGFloat = 0.0
    
    //MARK: --IBOutlet
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var headerContainerView: UIView!
    
    @IBOutlet weak var topConstrainsHeaderViewContainerView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        height = headerView.frame.size.height
    }
    
    func setUpUI() {    
        
        //Header view
        headerContainerView.displayShadowView2(shadowColor: UIColor.darkGray, borderColor: UIColor.clear, radius: 0, offSet: CGSize(width: 3, height: 0))  
        
        //display Avatar
        avatarImageView.layer.borderWidth = 5.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
        
        //Main TableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        for i in cellIdentifier {
            mainTableView.register(UINib(nibName: i, bundle: nil), forCellReuseIdentifier: i)
            
        }
    }
}

extension UserViewController: UITableViewDelegate,UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("DEBUG:    \(scrollView.contentOffset.y)" )
        let offsetY = scrollView.contentOffset.y
        
        var frame = headerView.frame
        
        if offsetY < 0 {
            topConstrainsHeaderViewContainerView.constant = offsetY
            frame.size.height = height - offsetY
        } else {}
        
        mainTableView.tableHeaderView = headerView
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "Cell1UserTableViewCell") as? Cell1UserTableViewCell else { fatalError()}
        self.avatarImageView.sd_setImage(with: URL(string:   cell.dataProfile.first?.hinh ?? ""), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "MacDinhTableViewCell", for: indexPath) as? MacDinhTableViewCell else {fatalError()}
            
            cell.iconImage.image = UIImage(named: "icon-profile-macdinhcuahang")
            cell.titleLabel.text = "Cửa hàng mặc định"
            return cell
        case 1:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "MacDinhTableViewCell", for: indexPath) as? MacDinhTableViewCell else {fatalError()}
            cell.iconImage.image = UIImage(named: "icon-profile-mk")
            cell.titleLabel.text = "Cài đặt mật khẩu"
            return cell
        case 2:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "MacDinhTableViewCell", for: indexPath) as? MacDinhTableViewCell else {fatalError()}
            cell.iconImage.image = UIImage(named: "icon-profile-caidat")
            cell.titleLabel.text = "Cài đặt chung"
            return cell
        case 3:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: "MacDinhTableViewCell", for: indexPath) as? MacDinhTableViewCell else {fatalError()}
            cell.iconImage.image = UIImage(named: "icon-profile-macdinhcuahang")
            cell.titleLabel.text = "Đăng xuất"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            UserHelper.clearUserData(key: UserKey.Token)
            UserHelper.clearUserData(key: UserKey.AutoLogin)
            //               self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    
}

