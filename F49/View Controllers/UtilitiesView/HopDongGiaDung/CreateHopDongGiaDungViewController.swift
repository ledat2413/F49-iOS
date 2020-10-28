//
//  CreateHopDongGiaDungViewController.swift
//  F49
//
//  Created by Le Dat on 10/23/20.
//  Copyright © 2020 Le Dat. All rights reserved.
//

import UIKit

class CreateHopDongGiaDungViewController: UIViewController {

    //MARK: --Vars
    
    var dataListCamDo: [CamDo] = []
    var dataStatus: [Status] = []
    //MARK: --IBOutlet
    
    @IBOutlet weak var navigation: NavigationBar!
    
    @IBOutlet weak var shopContainerView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: --View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    //MARK: --Func
    
    private func setUpUI(){
        
        //Navigation
        navigation.title = "Hợp đồng gia dụng"
        navigation.leftButton.addTarget(self, action: #selector(backView), for: .touchCancel)
        
        //TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CamDoTableViewCell", bundle: nil), forCellReuseIdentifier: "CamDoTableViewCell")
    }
    
    private func loadStatus(){
        MGConnection.requestArray(APIRouter.GetStatus, Status.self) { (result, error) in
            guard error == nil else {
                print("Error code \(String(describing: error?.mErrorCode)) and Error message \(String(describing: error?.mErrorMessage))")
                return
            }
            if let result = result{
                self.dataStatus = result
            }
        }
    }

    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: --IBAction

}

extension CreateHopDongGiaDungViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamDoTableViewCell", for: indexPath) as? CamDoTableViewCell else {
               fatalError()}
           //        if dataStatus[indexPath.row].id == "1" {
           //            cell.statusImage.image = UIImage(named: "icon-dangxuly")
           //        }else{
           //            cell.statusImage.isHidden = true
           //        }
          let data = dataListCamDo[indexPath.row]
           cell.idLabel.text = data.id
           cell.nameLabel.text = data.name
           cell.birthDateLabel.text = data.date
           cell.numberPhoneLabel.text = data.phone
           cell.nameItemLabel.text = data.brand
           cell.subItemLabel.text = "Nhãn hiệu"
           cell.subItemImage.image = UIImage(named: "icon-content-nhanhang")
           
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return CGFloat(100)
       }
    
    
}
